import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:kyudo_record/models/shoot_history.dart';
import 'package:kyudo_record/models/shoot_record.dart';
import 'package:kyudo_record/models/shoot_round.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseController extends GetxController {
  late Isar isar;

  Future<void> init() async {
    final dir = await getApplicationSupportDirectory();
    isar = await Isar.open(
      [ShootRecordSchema, ShootRoundSchema, ShootHistorySchema],
      directory: dir.path,
      inspector: true,
    );
  }

  Future<int?> addShootRecord(ShootRecord data, ShootRound link) async {
    int? recId;
    data.round.value = link;
    await isar.writeTxn(() async {
      recId = await isar.shootRecords.put(data);
      await data.round.save();
    });
    return recId;
  }

  Future<void> removeShootRecord(ShootRecord data) async {
    await isar.writeTxn(() async {
      await isar.shootRecords.delete(data.id);
    });
  }

  Future<int?> addShootRound(ShootRound data, ShootHistory link) async {
    int? recId;
    data.history.value = link;
    await isar.writeTxn(() async {
      recId = await isar.shootRounds.put(data);
      await data.history.save();
    });
    return recId;
  }

  Future<void> removeShootRound(ShootRound data) async {
    await isar.writeTxn(() async {
      await isar.shootRounds.delete(data.id);
    });
  }

  Future<int?> addShootHistory(ShootHistory data) async {
    int? recId;
    await isar.writeTxn(() async {
      recId = await isar.shootHistorys.put(data);
    });
    return recId;
  }

  Future<ShootHistory?> getShootHistoryByDate(String date) async {
    final result = await isar.shootHistorys.filter().dateEqualTo(date).findAll();
    return result.isEmpty ? null : result.first;
  }

  Future<List<ShootHistory>> getShootHistoryByMonth(String month) async {
    final result = await isar.shootHistorys.filter().dateStartsWith(month).findAll();
    return result.isEmpty ? [] : result;
  }

  void cleanDatabase() {
    isar.writeTxn(() async {
      await isar.shootHistorys.clear();
      await isar.shootRounds.clear();
      await isar.shootRecords.clear();
    });
  }
}
