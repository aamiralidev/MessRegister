import 'package:hive/hive.dart';
import 'core/day.dart';
import 'core/dish.dart';
import 'core/meal.dart';
import 'core/time.dart';
import 'weekdays.dart';
import 'core/bill_settings.dart';

part 'mess_profile.g.dart';

@HiveType(typeId: 7)
class MessProfile extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  WeekDays days = WeekDays();
  @HiveField(2)
  BillSettings billSettings = BillSettings(notifyAt: DateTime(2021));
  @HiveField(3)
  List<Meal> meals = [];
  @HiveField(4)
  int currentID = 0;
  MessProfile(
      {required this.name,
      BillSettings? billSettings,
      List<Meal>? meals,
      int? id}) {
    if (id != null) {
      currentID = id;
    }
    if (meals != null) {
      this.meals = meals;
    } else {
      // addMeal(Meal(
      //     id: getDefaultID(),
      //     name: "BreakFast",
      //     time: Time(hour: 9, minute: 0),
      //     notifyAfter: 30));
      addMeal(Meal(
          id: getDefaultID(),
          name: "Lunch",
          time: Time(hour: 12, minute: 0),
          notifyAfter: 60));
      addMeal(Meal(
          id: getDefaultID(),
          name: "Dinner",
          time: Time(hour: 18, minute: 00),
          notifyAfter: 60));
    }
    if (billSettings != null) {
      this.billSettings = billSettings;
    }
  }

  void addMeal(Meal meal) {
    meals.add(meal);
    days.addMeal(meal);
  }

  void addDefaultMeal() {
    Meal meal = Meal.getDefault(id: getDefaultID());
    meals.add(meal);
    days.addMeal(meal);
  }

  void removeMeal(Meal meal) {
    meals.remove(meal);
    days.removeMeal(meal);
  }

  void rescheduleNotification(Meal meal) {
    // print("rescheduling notification from mess profile");
    days.rescheduleNotification(meal);
  }

  int getDefaultID() {
    currentID++;
    return currentID - 1;
  }

  Dish? getDish(int mealId, int weekDay) {
    Dish? dish;
    for (Day day in days.days.keys) {
      if (day.toInt() == weekDay) {
        for (var meal in days.days[day]!.meals.keys) {
          if (meal.id == mealId) {
            dish = days.days[day]!.meals[meal];
          }
        }
        break;
      }
    }
    return dish;
  }
}
