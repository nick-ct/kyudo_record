import 'package:isar/isar.dart';
import 'package:kyudo_record/models/shoot_record.dart';

part 'shoot_round.g.dart';

@Collection()
class ShootRound {
  @Id()
  int id = Isar.autoIncrement;
  @Index()
  late DateTime dateTime;
  late int shootCount;
  late int hitCount;
  IsarLinks<ShootRecord> relatedRecord = IsarLinks<ShootRecord>();
}
