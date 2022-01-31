import 'package:hive/hive.dart';

part 'day.g.dart';

@HiveType(typeId: 0)
enum Day {
  // @JsonValue('monday')
  @HiveField(1)
  monday,
  // @JsonValue('tuesday')
  @HiveField(2)
  tuesday,
  // @JsonValue('wednesday')
  @HiveField(3)
  wednesday,
  // @JsonValue('thursday')
  @HiveField(4)
  thursday,
  // @JsonValue('friday')
  @HiveField(5)
  friday,
  // @JsonValue('saturday')
  @HiveField(6)
  saturday,
  // @JsonValue('sunday')
  @HiveField(7)
  sunday
}

extension ParseToString on Day {
  String toShortString() {
    String s = toString().split('.').last;
    return s[0].toUpperCase() + s.substring(1);
  }

  int toInt() {
    int result = -1;
    switch (this) {
      case Day.monday:
        result = 1;
        break;
      case Day.tuesday:
        result = 2;
        break;
      case Day.wednesday:
        result = 3;
        break;
      case Day.thursday:
        result = 4;
        break;
      case Day.friday:
        result = 5;
        break;
      case Day.saturday:
        result = 6;
        break;
      case Day.sunday:
        result = 7;
        break;
    }
    return result;
  }
}
