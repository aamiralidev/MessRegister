import 'package:hive/hive.dart';
part 'dish.g.dart';

@HiveType(typeId: 1)
class Dish extends HiveObject {
  @HiveField(0)
  String dishName;
  @HiveField(1)
  int dishPrice;
  Dish({required this.dishName, required this.dishPrice});
  static Dish getDefault() {
    return Dish(dishName: 'Enter Dish Name', dishPrice: 0);
  }
}
