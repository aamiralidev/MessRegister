import 'package:hive/hive.dart';
import 'core/day.dart';
import 'day_meal.dart';
import 'core/dish.dart';
import 'core/meal.dart';

part 'weekdays.g.dart';

@HiveType(typeId: 5)
class WeekDays extends HiveObject {
  @HiveField(0)
  Map<Day, DayMeals> _days = {
    for (var k in Day.values) k: DayMeals(day: k, status: true)
  };

  WeekDays({Map<Day, DayMeals>? days}) {
    if (days != null) {
      _days = days;
    }
  }

  void set(Day day) {
    _days[day]!.status = true;
  }

  void unset(Day day) {
    _days[day]!.status = false;
  }

  DayMeals get(Day day) {
    return _days[day]!;
  }

  Iterable<DayMeals> iter() {
    return _days.values;
  }

  Map<Day, DayMeals> get days => _days;

  void addMeal(Meal meal) {
    for (var day in _days.values) {
      day.add(meal, Dish.getDefault());
    }
  }

  void removeMeal(Meal meal) {
    for (var day in _days.values) {
      day.remove(meal);
    }
  }

  void rescheduleNotification(Meal meal) {
    // print("rescheduling notification from inside weekdays");
    for (var day in _days.values) {
      day.rescheduleNotification(meal);
    }
  }
}
