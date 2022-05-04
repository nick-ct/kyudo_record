import 'package:isar/isar.dart';

part 'shoot_record.g.dart';

@Collection()
class ShootRecord {
  @Id()
  int id = Isar.autoIncrement;
  @Index()
  late DateTime dateTime;
  late bool missed;
  late double hitPositionX;
  late double hitPositionY;
  late bool hitTarget;
}
