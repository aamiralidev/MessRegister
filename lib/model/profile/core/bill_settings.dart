import 'package:hive/hive.dart';

part 'bill_settings.g.dart';

// @JsonSerializable(explicitToJson: true)
@HiveType(typeId: 6)
class BillSettings extends HiveObject {
  @HiveField(0)
  DateTime notifyAt;
  @HiveField(1)
  int additionalCharges = 0;
  BillSettings({required this.notifyAt, int? additionalCharges}) {
    if (additionalCharges != null) {
      this.additionalCharges = additionalCharges;
    }
  }
}
