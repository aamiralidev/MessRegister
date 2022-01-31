import 'package:hive/hive.dart';
import 'package:mess_record_app/model/profile/core/dish.dart';

part 'attendance.g.dart';

@HiveType(typeId: 8)
class Attendance extends HiveObject {
  @HiveField(0)
  int count = 0;
  @HiveField(1)
  Dish dish;
  @HiveField(2)
  String mealName;
  Attendance({required this.mealName, required this.dish, int? count}) {
    this.dish = dish;
    if (count != null) {
      this.count = count;
    }
  }
}
