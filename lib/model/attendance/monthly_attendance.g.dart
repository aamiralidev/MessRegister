// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_attendance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlyAttendanceAdapter extends TypeAdapter<MonthlyAttendance> {
  @override
  final int typeId = 10;

  @override
  MonthlyAttendance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlyAttendance(
      dateTime: fields[0] as DateTime,
    )..attendanceList = (fields[1] as Map).cast<int, DailyAttendance>();
  }

  @override
  void write(BinaryWriter writer, MonthlyAttendance obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.attendanceList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyAttendanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
