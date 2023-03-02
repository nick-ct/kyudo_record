import 'package:isar/isar.dart';
import 'package:kyudo_record/models/shoot_history.dart';
import 'package:kyudo_record/models/shoot_record.dart';

part 'shoot_round.g.dart';

@Collection()
class ShootRound {
  Id id = Isar.autoIncrement;
  late DateTime dateTime;
  late int shootCount;
  late int hitCount;
  //store enum index
  late int matoSize;
  IsarLinks<ShootRecord> relatedRecord = IsarLinks<ShootRecord>();

  @Backlink(to: 'relatedRound')
  final history = IsarLink<ShootHistory>();
}
