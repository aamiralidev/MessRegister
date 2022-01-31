import 'package:flutter/material.dart';
import 'package:mess_record_app/model/attendance/attendance_manager.dart';
import 'package:mess_record_app/model/profile/core/dish.dart';
import 'package:mess_record_app/model/profile/core/meal.dart';
import 'package:mess_record_app/model/profile/day_meal.dart';
import 'package:mess_record_app/model/profile/core/day.dart';
import 'dish_edit_widget.dart';

class DailyDetailsWidget extends StatefulWidget {
  final DayMeals dayMeals;
  const DailyDetailsWidget({Key? key, required this.dayMeals})
      : super(key: key);

  @override
  _DailyDetailsWidgetState createState() => _DailyDetailsWidgetState();
}

class _DailyDetailsWidgetState extends State<DailyDetailsWidget> {
  void updateDish(Meal meal, Dish dish) {
    AttendanceManager.getAttendanceRecord(DateTime.now())
        .updateDish(widget.dayMeals.day.toInt(), meal.id, dish);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: SizedBox(
        height: widget.dayMeals.meals.length * 100 + 40,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(widget.dayMeals.day.toShortString()),
            Expanded(
              child: Column(
                  children: widget.dayMeals.meals.keys
                      .map((e) => DishEditWidget(
                          meal: e,
                          dish: widget.dayMeals.meals[e]!,
                          updateDish: updateDish))
                      .toList()),
            ),
          ]),
        ),
      ),
    );
  }
}
