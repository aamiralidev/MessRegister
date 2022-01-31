import 'package:hive/hive.dart';
import 'profile/core/bill_settings.dart';
import 'profile/core/day.dart';
import 'profile/day_meal.dart';
import 'profile/mess_profile.dart';
import 'profile/core/dish.dart';
import 'profile/core/meal.dart';
import 'profile/core/time.dart';
import 'profile/weekdays.dart';
import 'attendance/attendance.dart';
import 'attendance/daily_attendance.dart';
import 'attendance/monthly_attendance.dart';
import 'attendance/attendance_manager.dart';

class Database {
  static MessProfile? profile;
  static bool loaded = true;
  static Box? profileBox;
  static Box? attendanceBox;

  static Future<void> init() async {
    Hive.registerAdapter(BillSettingsAdapter());
    Hive.registerAdapter(DayAdapter());
    Hive.registerAdapter(DayMealsAdapter());
    Hive.registerAdapter(DishAdapter());
    Hive.registerAdapter(MealAdapter());
    Hive.registerAdapter(TimeAdapter());
    Hive.registerAdapter(WeekDaysAdapter());
    Hive.registerAdapter(MessProfileAdapter());
    Hive.registerAdapter(AttendanceAdapter());
    Hive.registerAdapter(DailyAttendanceAdapter());
    Hive.registerAdapter(MonthlyAttendanceAdapter());
    await initProfile();
    try {
      attendanceBox = await Hive.openBox<MonthlyAttendance>('attendance');
    } catch (e) {}
    try {
      await Hive.openBox<bool>('theme');
    } catch (e) {}
  }

  static Future<void> initProfile() async {
    try {
      profileBox = await Hive.openBox<MessProfile>('profile');
      if (getProfile().get('Default') == null) {
        getProfile().put('Default', MessProfile(name: 'Default'));
        loaded = false;
      }
      profile = getProfile().get('Default');
    } catch (e) {}
  }

  static int index = 0;
  static Box getProfile() => Hive.box<MessProfile>('profile');
  static Box getAttendanceBox() => attendanceBox!;

  static MessProfile getDefaultProfile() {
    return profile!;
  }

  static MonthlyAttendance getAttendanceRecord(DateTime dateTime) {
    String key = generateKey(from: dateTime);
    if (getAttendanceBox().get(key) == null) {
      getAttendanceBox().put(key, MonthlyAttendance(dateTime: dateTime));
    }
    return getAttendanceBox().get(key);
  }

  static void saveProfile() {
    getProfile().put('Default', profile);
  }

  static void saveAttendanceRecord(
      DateTime dateTime, MonthlyAttendance attendanceRecord) {
    getAttendanceBox().put(generateKey(from: dateTime), attendanceRecord);
  }

  static void save() {
    saveProfile();
    saveAttendanceRecord(
        AttendanceManager.dateTime, AttendanceManager.attendanceRecord!);
  }

  static void dispose() {
    Hive.close();
  }

  static String generateKey({required DateTime from}) {
    return "${from.year}:${from.month}";
  }

  static bool? isDarkTheme() {
    return Hive.box<bool>('theme').get('isDarkTheme');
  }

  static void saveThemeMode(bool isDarkTheme) {
    Hive.box<bool>('theme').put('isDarkTheme', isDarkTheme);
  }
}
