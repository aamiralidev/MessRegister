// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_attendance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyAttendanceAdapter extends TypeAdapter<DailyAttendance> {
  @override
  final int typeId = 9;

  @override
  DailyAttendance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyAttendance(
      fields[0] as DateTime,
      records: (fields[1] as Map?)?.cast<int, Attendance>(),
    );
  }

  @override
  void write(BinaryWriter writer, DailyAttendance obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.records);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyAttendanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
