import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hci/constants/colors.dart';
import 'package:hci/models/energy_usage_model.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class EnergyChart extends StatelessWidget {
  final List<DailyUsage> usageData;
  final String timeFrame;

  const EnergyChart({
    super.key,
    required this.usageData,
    required this.timeFrame,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate max value with some padding for better visualization
    final maxY = usageData.isEmpty
        ? 10.0
        : (usageData.map((e) => e.usage).reduce((a, b) => a > b ? a : b) * 1.2)
            .ceilToDouble();

    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine if we need extra space reduction for yearly view
    final isYearlyView = timeFrame == 'Yearly';

    // Fixed width calculation to avoid overflow
    final chartWidth = isYearlyView ? screenWidth - 70 : null;
    // Reduce chart height to accommodate the bottom labels
    final chartHeight = isYearlyView ? 150.0 : 200.0;

    return Container(
      height: chartHeight + 50, // Add extra height for bottom labels
      width: chartWidth,
      padding: EdgeInsets.only(
        right: isYearlyView ? 0 : 8,
        top: isYearlyView ? 10 : 20,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        // Calculate appropriate bar width based on available width
        final availableWidth = constraints.maxWidth;
        final barWidth = _calculateBarWidth(availableWidth);

        // For yearly view, reduce the bar width further
        final adjustedBarWidth = isYearlyView ? barWidth * 0.7 : barWidth;

        return BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: maxY,
            minY: 0,
            gridData: FlGridData(
              show: true,
              horizontalInterval: maxY / 3,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.white.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: false,
            ),
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.white,
                tooltipRoundedRadius: 8,
                tooltipPadding: const EdgeInsets.all(4),
                tooltipMargin: 4,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  final usage = rod.toY.toStringAsFixed(1);
                  final date = usageData[groupIndex].date;
                  String dateLabel;

                  switch (timeFrame) {
                    case 'Daily':
                      dateLabel = DateFormat('HH:mm').format(date);
                      break;
                    case 'Weekly':
                      dateLabel = DateFormat('EEE').format(date);
                      break;
                    case 'Yearly':
                      dateLabel = DateFormat('MMM').format(date);
                      break;
                    default:
                      dateLabel = DateFormat('MMM d').format(date);
                  }

                  return BarTooltipItem(
                    '$dateLabel: $usage kWh',
                    const TextStyle(
                      color: AppColors.text,
                      fontWeight: FontWeight.bold,
                      fontSize: 8,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= usageData.length ||
                        value.toInt() < 0) {
                      return const SizedBox();
                    }

                    // Only show a subset of labels to avoid overcrowding
                    final shouldShowLabel = _shouldShowLabel(
                        value.toInt(), usageData.length, timeFrame);
                    if (!shouldShowLabel) {
                      return const SizedBox();
                    }

                    final date = usageData[value.toInt()].date;
                    String label = _getLabelForTimeFrame(date, timeFrame);

                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 5,
                        child: Text(
                          label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: isYearlyView ? false : true,
                  interval: maxY / 3,
                  getTitlesWidget: (value, meta) {
                    if (value == 0) return const SizedBox();
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 5,
                        child: Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                  reservedSize: isYearlyView ? 0 : 25,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: usageData.asMap().entries.map((entry) {
              final index = entry.key;
              final data = entry.value;

              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: data.usage,
                    color: Colors.white.withOpacity(0.8),
                    width: adjustedBarWidth,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: maxY,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          swapAnimationDuration:
              Duration.zero, // Disable animation for more predictable rendering
        );
      }),
    );
  }

  double _calculateBarWidth(double availableWidth) {
    // Determine bar width based on time frame and available width
    final numBars = usageData.length;
    if (numBars == 0) return 8.0;

    // For fewer bars, make them wider
    if (numBars <= 12) {
      return (availableWidth / (numBars * 2.5)).clamp(6.0, 15.0);
    }

    // For many bars, make them narrower
    return (availableWidth / (numBars * 2)).clamp(3.0, 10.0);
  }

  bool _shouldShowLabel(int index, int totalCount, String timeFrame) {
    if (totalCount <= 7) return true;

    switch (timeFrame) {
      case 'Daily':
        // For daily, show every 6th hour
        return index % 6 == 0 || index == totalCount - 1;
      case 'Weekly':
        // For weekly, show all days
        return true;
      case 'Monthly':
        // For monthly, show every 5th day
        return index % 5 == 0 || index == totalCount - 1;
      case 'Yearly':
        // Only show January, July and December for yearly view
        return index == 0 || index == 6 || index == totalCount - 1;
      default:
        return index % 3 == 0;
    }
  }

  String _getLabelForTimeFrame(DateTime date, String timeFrame) {
    switch (timeFrame) {
      case 'Daily':
        // Format hour (e.g., 8a, 12p)
        final hour = DateFormat('ha').format(date).toLowerCase();
        return hour.replaceAll('am', 'a').replaceAll('pm', 'p');
      case 'Weekly':
        // Format day name - first letter + second letter lowercase
        final day = DateFormat('E').format(date);
        return day.substring(0, min(2, day.length));
      case 'Monthly':
        // Format day number
        return date.day.toString();
      case 'Yearly':
        // Format month abbreviation for better readability
        return DateFormat('MMM').format(date).substring(0, 2);
      default:
        return date.day.toString();
    }
  }
}
