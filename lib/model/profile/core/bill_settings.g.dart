// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillSettingsAdapter extends TypeAdapter<BillSettings> {
  @override
  final int typeId = 6;

  @override
  BillSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillSettings(
      notifyAt: fields[0] as DateTime,
      additionalCharges: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BillSettings obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.notifyAt)
      ..writeByte(1)
      ..write(obj.additionalCharges);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
