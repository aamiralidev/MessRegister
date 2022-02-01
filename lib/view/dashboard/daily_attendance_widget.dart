import 'package:flutter/material.dart';
import 'package:mess_record_app/model/attendance/attendance.dart';
import 'package:mess_record_app/model/attendance/daily_attendance.dart';
import 'package:mess_record_app/view/dashboard/edit_attendance_widget.dart';
import 'package:intl/intl.dart';

import 'package:mess_record_app/model/database.dart';
import 'package:mess_record_app/model/profile/core/meal.dart';

class DailyAttendanceWidget extends StatefulWidget {
  DailyAttendance dailyAttendance;
  final Function() updateBill;
  DailyAttendanceWidget(
      {Key? key, required this.dailyAttendance, required this.updateBill})
      : super(key: key);

  @override
  _DailyAttendanceWidgetState createState() => _DailyAttendanceWidgetState();
}

class _DailyAttendanceWidgetState extends State<DailyAttendanceWidget> {
  Iterable<Attendance> addIfNotPresent() {
    for (Meal meal in Database.getDefaultProfile().meals) {
      widget.dailyAttendance.addIfNotPresent(meal.id, meal.name);
    }
    return widget.dailyAttendance.records.values;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: Card(
        elevation: 20.0,
        child: SizedBox(
          height: addIfNotPresent().length * 30 + 50,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(DateFormat('LLLL d')
                        .format(widget.dailyAttendance.date)),
                    Text(
                        DateFormat('EEEE').format(widget.dailyAttendance.date)),
                    // Text(widget.attendance.records.length.toString()),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: addIfNotPresent().length * 30,
                  child: Column(
                    children: addIfNotPresent()
                        .map((e) => EditAttendanceWidget(
                            attendance: e, updateBill: widget.updateBill))
                        .toList(),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
