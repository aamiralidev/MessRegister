import 'package:flutter/material.dart';
import 'package:mess_record_app/model/attendance/attendance_manager.dart';

import 'package:mess_record_app/model/profile/core/meal.dart';
import 'package:mess_record_app/model/profile/core/time.dart';

class MealWidget extends StatefulWidget {
  final Meal meal;
  final Function(Meal) removeMeal;
  const MealWidget({required this.meal, required this.removeMeal, Key? key})
      : super(key: key);
  @override
  _MealWidgetState createState() => _MealWidgetState(meal: meal);
}

class _MealWidgetState extends State<MealWidget> {
  final _nameController = TextEditingController();
  TimeOfDay? picked = TimeOfDay.now();
  Meal meal;

  List<int> minuteItems = [10, 20, 30, 40, 50, 60];
  String _selectedItem = '10';

  _MealWidgetState({required this.meal}) {
    _selectedItem = minuteItems[0].toString();
    picked = meal.time.toTimeOfDay();
    _selectedItem = meal.notifyAfter.toString();
    _nameController.addListener(() {
      meal.name = _nameController.text;
      // Database.saveProfile();
    });
  }

  Future<void> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
          context: context,
          initialTime: meal.time.toTimeOfDay(),
        )) ??
        null;
    if (picked != null) {
      setState(() {
        meal.time = Time.fromTimeOfDay(picked!);
        // Database.saveProfile();
        // Database.getDefaultProfile().rescheduleNotification(meal);
      });
    }
  }

  String getTimeString() {
    String timeString = '';
    String amperse = 'AM';
    if (meal.time.hour < 10) {
      timeString += '0' + meal.time.hour.toString();
    } else if (meal.time.hour <= 12) {
      timeString += meal.time.hour.toString();
    } else {
      timeString += (meal.time.hour - 12).toString();
      amperse = 'PM';
    }
    timeString += ':';
    if (meal.time.minute < 10) {
      timeString += '0' + meal.time.minute.toString();
    } else {
      timeString += meal.time.minute.toString();
    }
    timeString += ' ' + amperse;
    return timeString;
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.meal.name;
    if (widget.meal.name == "NotAssignedYet") {
      _nameController.text = '';
    }
    return Card(
      elevation: 5.0,
      child: Stack(children: [
        Positioned(
            right: -13,
            top: -13,
            child: IconButton(
                enableFeedback: true,
                icon: Icon(
                  Icons.cancel,
                  color: Colors.black.withOpacity(0.5),
                  size: 18,
                ),
                onPressed: () => setState(() {
                      widget.removeMeal(widget.meal);
                      // Database.saveProfile();
                    }))),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Focus(
                          onFocusChange: (bool hasFocus) {
                            if (!hasFocus) {
                              AttendanceManager.getAttendanceRecord(
                                      DateTime.now())
                                  .updateMealName(widget.meal);
                            }
                          },
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Meal Name',
                              // border: OutlineInputBorder(
                              //   borderSide: const BorderSide(
                              //       color: Colors.grey, width: 1),
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                            ),
                          ),
                        ),
                        flex: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => selectTime(context),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(getTimeString()),
                            ),
                          ),
                        ),
                        flex: 5,
                      ),
                    ],
                  ),
                ),
              ),
              Form(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Notify Me After "),
                    ),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _selectedItem,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      onChanged: (String? data) {
                        setState(() {
                          _selectedItem = data ?? '10';
                          meal.notifyAfter = int.parse(_selectedItem);
                          // Database.saveProfile();
                          // Database.getDefaultProfile()
                          //     .rescheduleNotification(meal);
                        });
                      },
                      items:
                          minuteItems.map<DropdownMenuItem<String>>((int val) {
                        return DropdownMenuItem<String>(
                          value: val.toString(),
                          child: Text(val.toString() + ' min'),
                        );
                      }).toList(),
                    ),
                    flex: 4,
                  )
                ],
              ))
            ],
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
