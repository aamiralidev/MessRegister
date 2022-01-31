import 'package:flutter/material.dart';
import 'package:mess_record_app/model/attendance/attendance_manager.dart';
import 'daily_attendance_widget.dart';
import 'package:mess_record_app/view/constants.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<int> monthList = [];
  int days = DateTime.now().day;
  int _selectedMonth = DateTime.now().month;
  int currentBill = 0;

  _DashboardState() {
    _controller = ScrollController(initialScrollOffset: 160.0 * 30);
  }

  ScrollController _controller = ScrollController(initialScrollOffset: 0);

  @override
  void initState() {
    super.initState();
    int month = DateTime.now().month;
    for (int i = 0; i < 12; i++) {
      if (month - i > 0) {
        monthList.add(month - i);
      } else {
        monthList.add(month - i + 12);
      }
    }
    _selectedMonth = monthList.first;
    updateDays();
    updateBill();
  }

  void updateBill() {
    setState(() {
      currentBill = AttendanceManager.getAttendanceRecord(
              getDateTimeFromMonth(_selectedMonth))
          .getTotalBill();
    });
  }

  DateTime getDateTimeFromMonth(int month) {
    if (month <= DateTime.now().month) {
      return DateTime(DateTime.now().year, month);
    }
    return DateTime(DateTime.now().year - 1, month);
  }

  void updateSelection(String? data) {
    setState(() {
      _selectedMonth = int.parse(data ?? monthList.first.toString());
    });
    updateDays();
    updateBill();
  }

  void updateDays() {
    DateTime currentDate = DateTime.now();
    setState(() {
      days = daysInMonth(
          _selectedMonth, getDateTimeFromMonth(_selectedMonth).year);
      _controller = ScrollController(initialScrollOffset: 30.0 * days);
    });
    if (_selectedMonth == currentDate.month) {
      setState(() {
        days = currentDate.day;
      });
    }
    print(days);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Constants.appName),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedMonth.toString(),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  // style: const TextStyle(color: Colors.black87, fontSize: 18),
                  onChanged: updateSelection,
                  items: monthList.map<DropdownMenuItem<String>>((int val) {
                    return DropdownMenuItem<String>(
                      value: val.toString(),
                      child:
                          Text(DateFormat('LLLL').format(DateTime(2000, val))),
                    );
                  }).toList(),
                ),
                flex: 4,
              ),
              Text('Total Bill ' +
                  AttendanceManager.getAttendanceRecord(
                          getDateTimeFromMonth(_selectedMonth))
                      .getTotalBill()
                      .toString()),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            controller: _controller,
            children: AttendanceManager.getAttendanceRecord(
                    getDateTimeFromMonth(_selectedMonth))
                .completeTo(days)
                .map((e) => DailyAttendanceWidget(
                      dailyAttendance: e,
                      updateBill: updateBill,
                    ))
                .toList(),
          ),
        ),
      ]),
    );
  }

  int daysInMonth(final int monthNum, final int year) {
    List<int> monthLength = [];

    monthLength.insert(0, 31);
    if (leapYear(year) == true) {
      monthLength.insert(1, 29);
    } else {
      monthLength.insert(1, 28);
    }
    monthLength.insert(2, 31);
    monthLength.insert(3, 30);
    monthLength.insert(4, 31);
    monthLength.insert(5, 30);
    monthLength.insert(6, 31);
    monthLength.insert(7, 31);
    monthLength.insert(8, 30);
    monthLength.insert(9, 31);
    monthLength.insert(10, 30);
    monthLength.insert(11, 31);

    return monthLength[monthNum - 1];
  }

  bool leapYear(int year) {
    bool leapYear = false;

    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true) {
      leapYear = false;
    } else if (year % 4 == 0) {
      leapYear = true;
    }

    return leapYear;
  }
}
