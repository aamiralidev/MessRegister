// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_meal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayMealsAdapter extends TypeAdapter<DayMeals> {
  @override
  final int typeId = 4;

  @override
  DayMeals read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayMeals(
      day: fields[0] as Day,
      status: fields[1] as bool,
      meals: (fields[2] as Map?)?.cast<Meal, Dish>(),
    )..notificationIds = (fields[3] as Map).cast<Meal, int>();
  }

  @override
  void write(BinaryWriter writer, DayMeals obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.meals)
      ..writeByte(3)
      ..write(obj.notificationIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayMealsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
