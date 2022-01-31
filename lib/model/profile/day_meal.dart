import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:mess_record_app/view/notifications.dart';
import 'package:mess_record_app/view/utilities.dart';
import 'core/day.dart';
import 'core/dish.dart';
import 'core/meal.dart';

part 'day_meal.g.dart';

@HiveType(typeId: 4)
class DayMeals extends HiveObject {
  @HiveField(0)
  final Day day;
  @HiveField(1)
  bool status;
  @HiveField(2)
  Map<Meal, Dish> meals = {};
  @HiveField(3)
  Map<Meal, int> notificationIds = {};

  DayMeals({required this.day, required this.status, Map<Meal, Dish>? meals}) {
    if (meals != null) {
      this.meals = meals;
    }
    // for (Meal meal in this.meals.keys) {
    //   addNotification(meal);
    // }
  }

  void add(Meal meal, Dish dish) {
    meals[meal] = dish;
    addNotification(meal);
  }

  void remove(Meal meal) {
    meals.remove(meal);
    cancelNotification(meal);
  }

  void update(Meal meal, Dish dish) => meals[meal] = dish;

  Future<void> addNotification(Meal meal) async {
    await cancelNotification(meal);
    if (status) {
      notificationIds[meal] = createUniqueId();
      TimeOfDay timeOfDay = meal.time.toNotificationTime(add: meal.notifyAfter);
      // print(
      // "scheduling notification on ${day.toInt() + 1} and hour is ${timeOfDay.hour} minute is ${timeOfDay.minute} with id ${notificationIds[meal]}");
      scheduleNotification(
          NotificationWeekAndTime(
              dayOfTheWeek: day.toInt(), timeOfDay: timeOfDay),
          id: notificationIds[meal]!,
          mealName: meal.name);
    } else {
      // print('day is disabled');
    }
  }

  Future<void> cancelNotification(Meal meal) async {
    if (notificationIds[meal] != null) {
      // print("removing notification with id ${notificationIds[meal]}");
      await cancelScheduledNotification(notificationIds[meal]!);
    }
  }

  Future<void> rescheduleNotification(Meal meal) async {
    print("rescheduling notification from inside day meal");
    addNotification(meal);
  }
}
