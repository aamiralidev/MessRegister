// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mess_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessProfileAdapter extends TypeAdapter<MessProfile> {
  @override
  final int typeId = 7;

  @override
  MessProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessProfile(
      name: fields[0] as String,
      billSettings: fields[2] as BillSettings?,
      meals: (fields[3] as List?)?.cast<Meal>(),
    )..days = fields[1] as WeekDays;
  }

  @override
  void write(BinaryWriter writer, MessProfile obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.days)
      ..writeByte(2)
      ..write(obj.billSettings)
      ..writeByte(3)
      ..write(obj.meals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
