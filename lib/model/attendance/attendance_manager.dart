import 'package:mess_record_app/model/database.dart';
import 'package:mess_record_app/model/attendance/monthly_attendance.dart';

class AttendanceManager {
  static DateTime dateTime = DateTime.now();
  static MonthlyAttendance? attendanceRecord;

  static void init() {
    attendanceRecord = Database.getAttendanceRecord(dateTime);
  }

  static MonthlyAttendance getAttendanceRecord(DateTime dt) {
    if (dt.year != dateTime.year || dt.month != dateTime.month) {
      if (attendanceRecord != null) {
        Database.saveAttendanceRecord(dateTime, attendanceRecord!);
      }
      dateTime = dt;
      attendanceRecord = Database.getAttendanceRecord(dateTime);
    }
    return attendanceRecord!;
  }
}
