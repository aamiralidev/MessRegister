// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayAdapter extends TypeAdapter<Day> {
  @override
  final int typeId = 0;

  @override
  Day read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return Day.monday;
      case 2:
        return Day.tuesday;
      case 3:
        return Day.wednesday;
      case 4:
        return Day.thursday;
      case 5:
        return Day.friday;
      case 6:
        return Day.saturday;
      case 7:
        return Day.sunday;
      default:
        return Day.monday;
    }
  }

  @override
  void write(BinaryWriter writer, Day obj) {
    switch (obj) {
      case Day.monday:
        writer.writeByte(1);
        break;
      case Day.tuesday:
        writer.writeByte(2);
        break;
      case Day.wednesday:
        writer.writeByte(3);
        break;
      case Day.thursday:
        writer.writeByte(4);
        break;
      case Day.friday:
        writer.writeByte(5);
        break;
      case Day.saturday:
        writer.writeByte(6);
        break;
      case Day.sunday:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
