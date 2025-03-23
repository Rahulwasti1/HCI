import 'package:flutter/material.dart';
import 'package:hci/models/energy_usage_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';

class EnergyProvider with ChangeNotifier {
  EnergyUsageModel? _energyData;
  bool _isLoading = false;
  String _selectedTimeFrame = 'Monthly'; // Daily, Weekly, Monthly, Yearly

  // Current energy data for the selected time frame
  double _currentEnergyUsage = 0.0;
  double _currentEstimatedCost = 0.0;

  EnergyUsageModel? get energyData => _energyData;
  bool get isLoading => _isLoading;
  String get selectedTimeFrame => _selectedTimeFrame;
  double get currentEnergyUsage => _currentEnergyUsage;
  double get currentEstimatedCost => _currentEstimatedCost;

  Future<void> loadEnergyData() async {
    _setLoading(true);
    try {
      // In a real app, this would be an API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Generate mock data for different time frames
      final now = DateTime.now();

      // Daily data - 24 hours for today
      final dailyData = List.generate(
        24,
        (index) => DailyUsage(
          date: DateTime(now.year, now.month, now.day, index),
          usage: 0.5 +
              (sin(index / 6) * 0.3) +
              Random().nextDouble() * 0.5, // Lower values for daily
        ),
      );

      // Weekly data - 7 days
      final weeklyData = List.generate(
        7,
        (index) {
          final date = now.subtract(Duration(days: 6 - index));
          return DailyUsage(
            date: date,
            usage: 5 +
                (sin(index / 2) * 2) +
                Random().nextDouble() * 3, // Moderate values for weekly
          );
        },
      );

      // Monthly data - 30 days
      final monthlyData = List.generate(
        30,
        (index) {
          final date =
              DateTime(now.year, now.month, 1).add(Duration(days: index));
          if (date.isAfter(now)) {
            return DailyUsage(date: date, usage: 0);
          }
          return DailyUsage(
            date: date,
            usage: 4 +
                (sin(index / 10) * 1.5) +
                Random().nextDouble() * 2, // Higher values for monthly
          );
        },
      );

      // Yearly data - 12 months
      final yearlyData = List.generate(
        12,
        (index) {
          final month = index + 1;
          return DailyUsage(
            date: DateTime(now.year, month, 15),
            usage: 75 +
                (cos(month / 3) * 10) +
                Random().nextDouble() * 5, // Reasonable values for yearly
          );
        },
      );

      // Generate room usage data
      final roomUsage = [
        RoomUsage(
          roomId: 'bedroom',
          roomName: 'Bedroom',
          roomImage: 'assets/images/bedroom.jpg',
          usage: 42.5,
        ),
        RoomUsage(
          roomId: 'kitchen',
          roomName: 'Kitchen',
          roomImage: 'assets/images/kitchen.jpg',
          usage: 56.8,
        ),
        RoomUsage(
          roomId: 'living',
          roomName: 'Living Room',
          roomImage: 'assets/images/living_room.jpg',
          usage: 38.2,
        ),
        RoomUsage(
          roomId: 'bathroom',
          roomName: 'Bathroom',
          roomImage: 'assets/images/bathroom.jpg',
          usage: 29.3,
        ),
      ];

      // Combine all data
      _energyData = EnergyUsageModel(
        energyUsage:
            166.8, // Default value, will be updated based on time frame
        estimatedCost:
            1668.0, // Default value, will be updated based on time frame
        dailyUsage: dailyData +
            weeklyData +
            monthlyData +
            yearlyData, // Store all data together
        roomUsage: roomUsage,
        dailyData: dailyData,
        weeklyData: weeklyData,
        monthlyData: monthlyData,
        yearlyData: yearlyData,
      );

      // Update current data based on selected time frame
      _updateCurrentData();

      // Cache data
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('energy_data', json.encode(_energyData!.toJson()));
    } catch (e) {
      // Handle error
      debugPrint('Error loading energy data: $e');
    } finally {
      _setLoading(false);
    }
  }

  void setTimeFrame(String timeFrame) {
    if (_selectedTimeFrame != timeFrame) {
      _selectedTimeFrame = timeFrame;
      _updateCurrentData();
      notifyListeners();
    }
  }

  void _updateCurrentData() {
    if (_energyData == null) return;

    // Get filtered data based on selected time frame
    final filteredData = getFilteredUsage();

    // Calculate total energy usage for the selected time frame
    _currentEnergyUsage = filteredData.fold(0, (sum, item) => sum + item.usage);

    // Set appropriate cost based on time frame and usage
    switch (_selectedTimeFrame) {
      case 'Daily':
        // Aim for around Rs 50
        _currentEstimatedCost = _currentEnergyUsage * 10;
        break;
      case 'Weekly':
        // Aim for around Rs 350
        _currentEstimatedCost = _currentEnergyUsage * 10;
        break;
      case 'Monthly':
        // Aim for around Rs 1400
        _currentEstimatedCost = _currentEnergyUsage * 10;
        break;
      case 'Yearly':
        // Aim for around Rs 9000
        _currentEstimatedCost = _currentEnergyUsage * 10;
        break;
      default:
        _currentEstimatedCost = _currentEnergyUsage * 10;
    }
  }

  List<DailyUsage> getFilteredUsage() {
    if (_energyData == null) return [];

    switch (_selectedTimeFrame) {
      case 'Daily':
        return _energyData!.dailyData;
      case 'Weekly':
        return _energyData!.weeklyData;
      case 'Yearly':
        return _energyData!.yearlyData;
      case 'Monthly':
      default:
        return _energyData!.monthlyData;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
