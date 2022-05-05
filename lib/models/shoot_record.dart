import 'package:isar/isar.dart';
import 'package:kyudo_record/models/shoot_round.dart';

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

  @Backlink(to: 'relatedRecord')
  final round = IsarLink<ShootRound>();
}
