import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:kyudo_record/models/shoot_record.dart';
import 'package:kyudo_record/models/shoot_round.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseController extends GetxController {
  late Isar isar;

  init() async {
    final dir = await getApplicationSupportDirectory();
    isar = await Isar.open(
      schemas: [ShootRecordSchema, ShootRoundSchema],
      directory: dir.path,
      inspector: true,
    );
  }

  Future<int?> addShootRecord(ShootRecord newRecord) async {
    int? recId;
    await isar.writeTxn((isar) async {
      recId = await isar.shootRecords.put(newRecord);
    });
    return recId;
  }

  Future<int?> addShootRound(ShootRound newRound) async {
    print('save round');
    int? recId;
    await isar.writeTxn((isar) async {
      recId = await isar.shootRounds.put(
        newRound,
        replaceOnConflict: true,
        saveLinks: true,
      );
    });
    return recId;
  }
}
