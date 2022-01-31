import 'dart:core';
import 'package:hive/hive.dart';
import 'package:mess_record_app/model/profile/core/dish.dart';

import 'package:mess_record_app/model/database.dart';
import 'package:mess_record_app/model/attendance/attendance.dart';

part 'daily_attendance.g.dart';

@HiveType(typeId: 9)
class DailyAttendance extends HiveObject {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  Map<int, Attendance> records = {};
  DailyAttendance(this.date, {Map<int, Attendance>? records}) {
    if (records != null) {
      this.records = records;
    }
  }
  void add(
      {required int mealId,
      required String mealName,
      required Attendance attendance}) {
    records[mealId] = attendance;
  }

  void addIfNotPresent(int mealId, String? mealName) {
    if (records[mealId] == null) {
      if (mealName == null) {
        for (var meal in Database.getDefaultProfile().meals) {
          if (meal.id == mealId) {
            mealName = meal.name;
          }
        }
      }
      records[mealId] = Attendance(
          mealName: mealName!,
          dish: Database.getDefaultProfile().getDish(mealId, date.weekday) ??
              Dish.getDefault());
    }
  }

  int getDailyTotal() {
    int sum = 0;
    for (var attendance in records.values) {
      sum += attendance.count * attendance.dish.dishPrice;
    }
    return sum;
  }
}
