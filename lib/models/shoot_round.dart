import 'package:isar/isar.dart';
import 'package:kyudo_record/models/shoot_record.dart';

part 'shoot_round.g.dart';

@Collection()
class ShootRound {
  @Id()
  int id = Isar.autoIncrement;
  @Index()
  final String date =
      '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}';
  late int round;
  late int shootCount;
  IsarLinks<ShootRecord> relatedRecord = IsarLinks<ShootRecord>();
}
