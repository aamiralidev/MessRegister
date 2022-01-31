import 'package:hive/hive.dart';

import 'time.dart';
part 'meal.g.dart';

@HiveType(typeId: 2)
class Meal extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  Time time;
  @HiveField(2)
  int notifyAfter;
  @HiveField(3)
  int id;
  Meal(
      {required this.name,
      required this.id,
      required this.time,
      required this.notifyAfter});
  static Meal getDefault({required int id}) {
    return Meal(
        id: id,
        name: 'NotAssignedYet',
        time: Time(hour: 0, minute: 0),
        notifyAfter: 60);
  }
}
