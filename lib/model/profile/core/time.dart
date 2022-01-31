import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'time.g.dart';

@HiveType(typeId: 3)
class Time extends HiveObject {
  @HiveField(0)
  int hour = 0;
  @HiveField(1)
  int minute = 0;
  Time({required this.hour, required this.minute});

  Time getDefault() {
    return Time(hour: 0, minute: 0);
  }

  static Time fromTimeOfDay(TimeOfDay time) {
    return Time(hour: time.hour, minute: time.minute);
  }

  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }

  TimeOfDay toNotificationTime({required int add}) {
    int hr = hour + (minute + add) ~/ 60;
    int min = (minute + add) % 60;
    return TimeOfDay(hour: hr, minute: min);
  }
}
