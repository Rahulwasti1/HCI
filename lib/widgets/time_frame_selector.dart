import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';

class TimeFrameSelector extends StatelessWidget {
  final String selectedTimeFrame;
  final Function(String) onTimeFrameSelected;

  const TimeFrameSelector({
    super.key,
    required this.selectedTimeFrame,
    required this.onTimeFrameSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Available time frames
    const timeFrames = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      child: LayoutBuilder(builder: (context, constraints) {
        final buttonWidth = (constraints.maxWidth - 16) / 4;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: timeFrames.map((timeFrame) {
            final isSelected = selectedTimeFrame == timeFrame;

            return SizedBox(
              width: buttonWidth,
              child: Material(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  onTap: () => onTimeFrameSelected(timeFrame),
                  borderRadius: BorderRadius.circular(100),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        timeFrame,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? AppColors.primary : Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}
