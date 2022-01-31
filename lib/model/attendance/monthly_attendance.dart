import 'package:hive/hive.dart';
import 'package:mess_record_app/model/profile/core/dish.dart';
import 'package:mess_record_app/model/profile/core/meal.dart';
import 'package:mess_record_app/model/attendance/daily_attendance.dart';
import 'package:mess_record_app/model/database.dart';
part 'monthly_attendance.g.dart';

@HiveType(typeId: 10)
class MonthlyAttendance extends HiveObject {
  @HiveField(0)
  DateTime dateTime;
  @HiveField(1)
  Map<int, DailyAttendance> attendanceList = {};
  MonthlyAttendance(
      {required this.dateTime, Map<int, DailyAttendance>? records}) {
    if (records != null) {
      attendanceList = records;
    }
  }
  void add(int day, DailyAttendance attendance) =>
      attendanceList[day] = attendance;

  DailyAttendance getAttendance(int day) {
    addIfNotPresent(day);
    return attendanceList[day]!;
  }

  int getTotalBill() {
    int sum = 0;
    for (var attendance in attendanceList.values) {
      sum += attendance.getDailyTotal();
    }
    sum += Database.getDefaultProfile().billSettings.additionalCharges;
    return sum;
  }

  List<DailyAttendance> completeTo(int days) {
    for (int i = 1; i <= days; i++) {
      addIfNotPresent(i);
    }
    return attendanceList.values.toList();
  }

  void addIfNotPresent(int day) {
    if (attendanceList[day] == null) {
      add(day, DailyAttendance(DateTime(dateTime.year, dateTime.month, day)));
    }
  }

  void updateMealName(Meal meal) {
    for (var attendance in attendanceList.values) {
      for (var id in attendance.records.keys) {
        if (id == meal.id) {
          attendance.records[id]?.mealName = meal.name;
        }
      }
    }
  }

  void updateDish(int weekDay, int mealId, Dish dish) {
    for (var attendance in attendanceList.values) {
      if (attendance.date.weekday == weekDay) {
        attendance.records[mealId]?.dish = dish;
      }
    }
  }
}
