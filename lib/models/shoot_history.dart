import 'package:isar/isar.dart';
import 'package:kyudo_record/models/shoot_round.dart';

part 'shoot_history.g.dart';

@Collection()
class ShootHistory {
  @Id()
  int id = Isar.autoIncrement;
  late String date;
  late int totalRound;
  late int totalShoot;
  late int totalHitTarget;
  IsarLinks<ShootRound> relatedRound = IsarLinks<ShootRound>();
}
