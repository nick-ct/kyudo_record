import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:kyudo_record/models/shoot_history.dart';
import 'package:kyudo_record/models/shoot_record.dart';
import 'package:kyudo_record/models/shoot_round.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseController extends GetxController {
  late Isar isar;

  init() async {
    final dir = await getApplicationSupportDirectory();
    isar = await Isar.open(
      schemas: [ShootRecordSchema, ShootRoundSchema, ShootHistorySchema],
      directory: dir.path,
      inspector: true,
    );
  }

  Future<int?> addShootRecord(ShootRecord data) async {
    int? recId;
    await isar.writeTxn((isar) async {
      recId = await isar.shootRecords.put(
        data,
        replaceOnConflict: true,
        saveLinks: true,
      );
    });
    return recId;
  }

  Future<void> removeShootRecord(ShootRecord data) async {
    await isar.writeTxn((isar) async {
      await isar.shootRecords.delete(data.id);
    });
  }

  Future<int?> addShootRound(ShootRound data) async {
    int? recId;
    await isar.writeTxn((isar) async {
      recId = await isar.shootRounds.put(
        data,
        replaceOnConflict: true,
        saveLinks: true,
      );
    });
    return recId;
  }

  Future<void> removeShootRound(ShootRound data) async {
    await isar.writeTxn((isar) async {
      await isar.shootRounds.delete(data.id);
    });
  }

  Future<int?> addShootHistory(ShootHistory data) async {
    int? recId;
    await isar.writeTxn((isar) async {
      recId = await isar.shootHistorys.put(
        data,
        replaceOnConflict: true,
        saveLinks: true,
      );
    });
    return recId;
  }

  Future<ShootHistory?> getShootHistoryByDate(String date) async {
    final result = await isar.shootHistorys.where().dateEqualTo(date).findAll();
    return result.isEmpty ? null : result.first;
  }

  void cleanDatabase() {
    isar.writeTxn((isar) async {
      await isar.shootHistorys.clear();
      await isar.shootRounds.clear();
      await isar.shootRecords.clear();
    });
    print('clear db finish');
  }
}
