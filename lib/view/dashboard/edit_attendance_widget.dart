import 'package:flutter/material.dart';
import 'package:mess_record_app/model/attendance/attendance.dart';
import 'package:mess_record_app/view/constants.dart';

class EditAttendanceWidget extends StatefulWidget {
  final Attendance attendance;
  final Function() updateBill;
  EditAttendanceWidget(
      {Key? key, required this.attendance, required this.updateBill})
      : super(key: key);

  @override
  _EditAttendanceWidgetState createState() => _EditAttendanceWidgetState();
}

class _EditAttendanceWidgetState extends State<EditAttendanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: SizedBox(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.attendance.mealName),
            Switch(
              value: widget.attendance.count != 0,
              onChanged: (bool val) {
                setState(() {
                  widget.attendance.count = (val == false ? 0 : 1);
                });
                widget.updateBill();
              },
              activeColor: Constants.primaryColor,
              activeTrackColor: Constants.primaryColor.shade200,
            )
          ],
        ),
      ),
    );
  }
}
