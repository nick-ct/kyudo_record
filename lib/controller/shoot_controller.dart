import 'package:get/get.dart';
import 'package:kyudo_record/classes/mato_widget.dart';
import 'package:kyudo_record/controller/database_controller.dart';
import 'package:kyudo_record/models/shoot_history.dart';
import 'package:kyudo_record/models/shoot_record.dart';
import 'package:kyudo_record/models/shoot_round.dart';

class ShootController extends GetxController {
  final DatabaseController _databaseController = Get.find();
  Rx<DateTime> currDate = DateTime.now().obs;
  Rx<bool> loading = false.obs;

  late ShootHistory? shootHistory;
  RxList<ShootRound> shootRounds = <ShootRound>[].obs;
  MatoSize currMatoSize = MatoSize.metre28;

  String currDateString() =>
      '${currDate.value.year.toString()}-${currDate.value.month.toString().padLeft(2, '0')}-${currDate.value.day.toString().padLeft(2, '0')}';

  Future<void> init() async {
    await loadHistory();
  }

  Future<void> updateDate(DateTime newDateTime) async {
    currDate.value = newDateTime;
    await loadHistory();
  }

  Future<void> loadHistory() async {
    loading.value = true;
    shootHistory = null;
    shootRounds.clear();

    shootHistory = await _databaseController.getShootHistoryByDate(currDateString());

    if (shootHistory != null) {
      await shootHistory?.relatedRound.load();
      for (int i = 0; i < shootHistory!.relatedRound.toList().length; i++) {
        await shootHistory?.relatedRound.toList()[i].relatedRecord.load();
      }

      List<ShootRound>? roundData = shootHistory?.relatedRound.toList();
      roundData?.sort(((a, b) => a.dateTime.isAfter(b.dateTime) ? 1 : 0));
      shootRounds.addAll(roundData!);

      if (shootRounds.isEmpty || shootRounds.last.shootCount == 4) {
        newShootRound();
      }
    } else {
      shootHistory = ShootHistory()
        ..date = currDateString()
        ..totalRound = 0
        ..totalShoot = 0
        ..totalHitTarget = 0;
      newShootRound();
    }
    loading.value = false;
  }

  void newShootRound() {
    ShootRound newShootRound = ShootRound()
      ..dateTime = DateTime.now()
      ..shootCount = 0
      ..matoSize = currMatoSize.index
      ..hitCount = 0;
    shootRounds.add(newShootRound);
    shootHistory?.relatedRound.add(newShootRound);
    shootHistory?.totalRound += 1;
  }

  Future<void> addShootRecord(ShootRecord shootRecord, int round) async {
    if (shootRounds[round].shootCount >= 4) return;

    await _databaseController.addShootRecord(shootRecord);
    //update Round
    if (shootRecord.hitTarget) shootRounds[round].hitCount += 1;
    shootRounds[round].shootCount += 1;
    shootRounds[round].relatedRecord.add(shootRecord);
    await _databaseController.addShootRound(shootRounds[round]);

    //update History
    if (shootRecord.hitTarget) shootHistory?.totalHitTarget += 1;
    shootHistory?.totalShoot += 1;
    await _databaseController.addShootHistory(shootHistory!);

    //check round
    if (shootRounds.last.shootCount == 4) {
      newShootRound();
    }
  }

  Future<void> updateShootRecord(ShootRecord originalShootRecord, ShootRecord newShootRecord) async {
    await originalShootRecord.round.load();
    ShootRound round = shootRounds.where((element) => element.id == originalShootRecord.round.value?.id).first;

    if (originalShootRecord.hitTarget != newShootRecord.hitTarget) {
      if (newShootRecord.hitTarget) {
        round.hitCount += 1;
        shootHistory?.totalHitTarget += 1;
      } else {
        round.hitCount -= 1;
        shootHistory?.totalHitTarget -= 1;
      }
    }

    round.relatedRecord.where((element) => element.id == originalShootRecord.id).first
      ..hitPositionX = newShootRecord.hitPositionX
      ..hitPositionY = newShootRecord.hitPositionY
      ..hitTarget = newShootRecord.hitTarget
      ..missed = newShootRecord.missed;

    await _databaseController.addShootRecord(newShootRecord);
    await _databaseController.addShootRound(round);
    await _databaseController.addShootHistory(shootHistory!);
  }

  Future<void> removeShootRecord(ShootRecord shootRecord) async {
    await shootRecord.round.load();
    ShootRound round = shootRounds.where((element) => element.id == shootRecord.round.value?.id).first;

    round.shootCount -= 1;
    shootHistory?.totalShoot -= 1;
    if (shootRecord.hitTarget) {
      round.hitCount -= 1;
      shootHistory?.totalHitTarget -= 1;
    }

    round.relatedRecord.remove(shootRecord);

    await _databaseController.removeShootRecord(shootRecord);
    await _databaseController.addShootRound(round);
    await _databaseController.addShootHistory(shootHistory!);
  }

  void updateMatoSize(MatoSize matoSize) {
    currMatoSize = matoSize;
  }

  Future<void> updateRoundMatoSize(MatoSize matoSize, ShootRound shootRound) async {
    Mato mato = Mato();
    mato.updateMatoSize(matoSize);
    double paintArea = Get.width * 0.95 > 500 ? 500 : Get.width * 0.95;
    double deductPosition = paintArea / 2;

    shootRound.matoSize = matoSize.index;

    //reset round hit count
    shootHistory?.totalHitTarget -= shootRound.hitCount;
    shootRound.hitCount = 0;

    //test hit for every shoot in round
    for (int i = 0; i < shootRound.shootCount; i++) {
      ShootRecord record = shootRound.relatedRecord.elementAt(i);
      record.hitTarget = mato.testHitTarget(record.hitPositionX * deductPosition, record.hitPositionY * deductPosition);
      _databaseController.addShootRecord(record);
      if (record.hitTarget) {
        shootHistory?.totalHitTarget++;
        shootRound.hitCount++;
      }
    }

    _databaseController.addShootRound(shootRound);
    _databaseController.addShootHistory(shootHistory!);
  }

  Future<void> removeShootRound(ShootRound shootRound) async {
    shootHistory?.totalHitTarget -= shootRound.hitCount;
    shootHistory?.totalShoot -= shootRound.shootCount;
    shootHistory?.totalRound -= 1;
    shootHistory?.relatedRound.remove(shootRound);
    await _databaseController.addShootHistory(shootHistory!);

    for (int i = 0; i < shootRound.relatedRecord.length; i++) {
      await _databaseController.removeShootRecord(shootRound.relatedRecord.toList()[i]);
    }

    await _databaseController.removeShootRound(shootRound);
  }
}
