// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekdays.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeekDaysAdapter extends TypeAdapter<WeekDays> {
  @override
  final int typeId = 5;

  @override
  WeekDays read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeekDays().._days = (fields[0] as Map).cast<Day, DayMeals>();
  }

  @override
  void write(BinaryWriter writer, WeekDays obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj._days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeekDaysAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
