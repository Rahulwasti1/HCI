class EnergyUsageModel {
  final double energyUsage; // in kWH
  final double estimatedCost; // in Rs
  final List<DailyUsage> dailyUsage;
  final List<RoomUsage> roomUsage;

  // Specific data for each time frame
  final List<DailyUsage> dailyData;
  final List<DailyUsage> weeklyData;
  final List<DailyUsage> monthlyData;
  final List<DailyUsage> yearlyData;

  EnergyUsageModel({
    required this.energyUsage,
    required this.estimatedCost,
    required this.dailyUsage,
    required this.roomUsage,
    required this.dailyData,
    required this.weeklyData,
    required this.monthlyData,
    required this.yearlyData,
  });

  factory EnergyUsageModel.fromJson(Map<String, dynamic> json) {
    List<DailyUsage> dailyUsageList = [];
    if (json['daily_usage'] != null) {
      json['daily_usage'].forEach((v) {
        dailyUsageList.add(DailyUsage.fromJson(v));
      });
    }

    List<DailyUsage> dailyDataList = [];
    if (json['daily_data'] != null) {
      json['daily_data'].forEach((v) {
        dailyDataList.add(DailyUsage.fromJson(v));
      });
    }

    List<DailyUsage> weeklyDataList = [];
    if (json['weekly_data'] != null) {
      json['weekly_data'].forEach((v) {
        weeklyDataList.add(DailyUsage.fromJson(v));
      });
    }

    List<DailyUsage> monthlyDataList = [];
    if (json['monthly_data'] != null) {
      json['monthly_data'].forEach((v) {
        monthlyDataList.add(DailyUsage.fromJson(v));
      });
    }

    List<DailyUsage> yearlyDataList = [];
    if (json['yearly_data'] != null) {
      json['yearly_data'].forEach((v) {
        yearlyDataList.add(DailyUsage.fromJson(v));
      });
    }

    List<RoomUsage> roomUsageList = [];
    if (json['room_usage'] != null) {
      json['room_usage'].forEach((v) {
        roomUsageList.add(RoomUsage.fromJson(v));
      });
    }

    return EnergyUsageModel(
      energyUsage: json['energy_usage']?.toDouble() ?? 0.0,
      estimatedCost: json['estimated_cost']?.toDouble() ?? 0.0,
      dailyUsage: dailyUsageList,
      roomUsage: roomUsageList,
      dailyData: dailyDataList,
      weeklyData: weeklyDataList,
      monthlyData: monthlyDataList,
      yearlyData: yearlyDataList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'energy_usage': energyUsage,
      'estimated_cost': estimatedCost,
      'daily_usage': dailyUsage.map((e) => e.toJson()).toList(),
      'room_usage': roomUsage.map((e) => e.toJson()).toList(),
      'daily_data': dailyData.map((e) => e.toJson()).toList(),
      'weekly_data': weeklyData.map((e) => e.toJson()).toList(),
      'monthly_data': monthlyData.map((e) => e.toJson()).toList(),
      'yearly_data': yearlyData.map((e) => e.toJson()).toList(),
    };
  }
}

class DailyUsage {
  final DateTime date;
  final double usage; // in kWH

  DailyUsage({required this.date, required this.usage});

  factory DailyUsage.fromJson(Map<String, dynamic> json) {
    return DailyUsage(
      date: DateTime.parse(json['date']),
      usage: json['usage']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'usage': usage,
    };
  }
}

class RoomUsage {
  final String roomId;
  final String roomName;
  final String roomImage;
  final double usage; // in kWH

  RoomUsage({
    required this.roomId,
    required this.roomName,
    required this.roomImage,
    required this.usage,
  });

  factory RoomUsage.fromJson(Map<String, dynamic> json) {
    return RoomUsage(
      roomId: json['room_id'] ?? '',
      roomName: json['room_name'] ?? '',
      roomImage: json['room_image'] ?? '',
      usage: json['usage']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'room_id': roomId,
      'room_name': roomName,
      'room_image': roomImage,
      'usage': usage,
    };
  }
}
