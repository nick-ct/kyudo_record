import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_heat_map/flutter_heat_map.dart';
import 'package:kyudo_record/controller/database_controller.dart';
import 'package:kyudo_record/models/shoot_history.dart';
import 'package:kyudo_record/models/shoot_record.dart';
import 'package:kyudo_record/models/shoot_round.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShootRecordMato extends StatefulWidget {
  final String currDate;
  const ShootRecordMato({Key? key, required this.currDate}) : super(key: key);

  @override
  State<ShootRecordMato> createState() => _ShootRecordMatoState();
}

class _ShootRecordMatoState extends State<ShootRecordMato> {
  final DatabaseController _databaseController = Get.find();

  double paintArea = Get.width * 0.95 > 500 ? 500 : Get.width * 0.95;
  late double deductPosition = paintArea / 2;
  double diameter = Get.width * 0.65 > 325 ? 325 : Get.width * 0.65;
  late double radius = diameter / 2;

  int heatmapWidth = 350;

  ShootHistory? shootHistory;
  RxList<ShootRound> shootRounds = <ShootRound>[].obs;
  RxList<ShootRecord> displayRecords = <ShootRecord>[].obs;
  Rxn<ShootRecord> currShoot = Rxn<ShootRecord>();
  Rxn<ShootRecord> updatingShoot = Rxn<ShootRecord>();

  Uint8List? heatmapBytes;
  Rx<bool> showHitPoint = true.obs;
  Rx<bool> showHeatmap = true.obs;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    reset();
    await loadHistory();
    setState(() {});
  }

  bool testHitTarget(double? x, double? y) => sqrt(pow(x ?? 0.0, 2) + pow(y ?? 0.0, 2)) < (radius / deductPosition);

  void resetCurrShoot() => currShoot.value = null;

  void resetUpdatingShoot() => updatingShoot.value = null;

  Future<void> loadHistory() async {
    shootHistory = await _databaseController.getShootHistoryByDate(widget.currDate);

    if (shootHistory != null) {
      await shootHistory?.relatedRound.load();
      for (int i = 0; i < shootHistory!.relatedRound.toList().length; i++) {
        await shootHistory?.relatedRound.toList()[i].relatedRecord.load();
      }

      List<ShootRound>? roundData = shootHistory?.relatedRound.toList();
      roundData?.sort(((a, b) => a.dateTime.isAfter(b.dateTime) ? 1 : 0));
      shootRounds.addAll(roundData!);
      for (int i = 0; i < roundData.length; i++) {
        List<ShootRecord> relatedRecords = shootRounds[i].relatedRecord.toList();
        relatedRecords.sort((a, b) => a.dateTime.isAfter(b.dateTime) ? 1 : 0);
        displayRecords.addAll(relatedRecords.where((element) => !element.missed));
      }

      if (displayRecords.isNotEmpty) await updateHeatMap();

      if (shootHistory!.relatedRound.last.shootCount == 4) {
        newShootRound();
      }
    } else {
      shootHistory = ShootHistory()
        ..date = widget.currDate
        ..totalRound = 0
        ..totalShoot = 0
        ..totalHitTarget = 0;
      newShootRound();
    }
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

    if (!shootRecord.missed) {
      displayRecords.add(shootRecord);
      await updateHeatMap();
    }

    resetCurrShoot();

    setState(() {});
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

    if (!newShootRecord.missed) {
      displayRecords.add(newShootRecord);
    }

    await resetScreen();
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

    await resetScreen();
  }

  void newShootRound() {
    ShootRound newShootRound = ShootRound()
      ..dateTime = DateTime.now()
      ..shootCount = 0
      ..hitCount = 0;
    shootRounds.add(newShootRound);
    shootHistory?.relatedRound.add(newShootRound);
    shootHistory?.totalRound += 1;
  }

  Future<void> removeShootRound(ShootRound shootRound) async {
    shootHistory?.totalHitTarget -= shootRound.hitCount;
    shootHistory?.totalShoot -= shootRound.shootCount;
    shootHistory?.totalRound -= 1;
    shootHistory?.relatedRound.remove(shootRound);
    await _databaseController.addShootHistory(shootHistory!);

    for (int i = 0; i < shootRound.relatedRecord.length; i++) {
      displayRecords
          .removeAt(displayRecords.indexWhere((element) => element.id == shootRound.relatedRecord.toList()[i].id));
      await _databaseController.removeShootRecord(shootRound.relatedRecord.toList()[i]);
    }

    await _databaseController.removeShootRound(shootRound);

    await resetScreen();
  }

  Future<void> updateHeatMap() async {
    if (displayRecords.isEmpty) {
      heatmapBytes = null;
      return;
    }
    ImageProvider? provider =
        AssetImage('assets/images/transparent' + heatmapWidth.toString() + 'x' + heatmapWidth.toString() + '.png');
    ui.Image? image = await HeatMap.imageProviderToUiImage(provider);

    HeatMapPage heatMapPage = HeatMapPage(
      image: image,
      events: displayRecords
          .map((element) => HeatMapEvent(
                  location: Offset(
                (element.hitPositionX * heatmapWidth / 2 + heatmapWidth / 2),
                (element.hitPositionY * heatmapWidth / 2 * -1 + heatmapWidth / 2),
              )))
          .toList(),
    );
    heatmapBytes = await HeatMap.process(heatMapPage);
  }

  void reset() {
    shootHistory = null;
    shootRounds.clear();
    displayRecords.clear();
    resetCurrShoot();
    heatmapBytes = null;
    showHitPoint.value = true;
    showHeatmap.value = true;
  }

  Future<void> resetScreen() async {
    await updateHeatMap();
    showHeatmap.value = true;

    resetUpdatingShoot();
    resetCurrShoot();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Get.width,
            width: Get.width,
            child: Center(
              child: GestureDetector(
                onTapDown: (tapDownDetails) {
                  currShoot.value = ShootRecord()
                    ..missed = false
                    ..dateTime = DateTime.now()
                    ..hitPositionX = (tapDownDetails.localPosition.dx - deductPosition) / deductPosition
                    ..hitPositionY = (tapDownDetails.localPosition.dy - deductPosition) * -1 / deductPosition
                    ..hitTarget = testHitTarget(
                      (tapDownDetails.localPosition.dx - deductPosition) / deductPosition,
                      (tapDownDetails.localPosition.dy - deductPosition) * -1 / deductPosition,
                    );

                  if (updatingShoot.value != null) {
                    currShoot.value?.id = updatingShoot.value!.id;
                    currShoot.value?.dateTime = updatingShoot.value!.dateTime;
                  }
                },
                child: Obx(
                  () => Container(
                    width: paintArea,
                    height: paintArea,
                    decoration: BoxDecoration(color: Colors.brown[400]),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        //Mato Widget List
                        ...[
                          Container(
                            width: diameter,
                            height: diameter,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: diameter * (14.7 / 18),
                            height: diameter * (14.7 / 18),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: diameter * (11.7 / 18),
                            height: diameter * (11.7 / 18),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: diameter * (10.2 / 18),
                            height: diameter * (10.2 / 18),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: diameter * (7.2 / 18),
                            height: diameter * (7.2 / 18),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: diameter * (3.6 / 18),
                            height: diameter * (3.6 / 18),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                        //curr record
                        if (currShoot.value != null)
                          Positioned(
                            top: (currShoot.value?.hitPositionY ?? 0.0) * deductPosition * -1 + deductPosition - 12,
                            left: (currShoot.value?.hitPositionX ?? 0.0) * deductPosition + deductPosition - 12,
                            child: const SizedBox(
                              height: 24,
                              width: 24,
                              child: Center(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        //display record
                        if (showHitPoint.value)
                          ...displayRecords
                              .where((p0) => !p0.missed)
                              .map((record) => Positioned(
                                    top: record.hitPositionY * deductPosition * -1 + deductPosition - 12,
                                    left: record.hitPositionX * deductPosition + deductPosition - 12,
                                    child: const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Center(
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        if (showHeatmap.value && heatmapBytes != null)
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Image.memory(
                              heatmapBytes!,
                              width: paintArea,
                              height: paintArea,
                              fit: BoxFit.contain,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.bullseye,
                  size: 40,
                ),
                const Spacer(),
                Obx(
                  () => updatingShoot.value != null
                      ? ElevatedButton.icon(
                          onPressed: () async => await removeShootRecord(updatingShoot.value!),
                          icon: const Icon(Icons.delete),
                          label: const Text('remove'),
                        )
                      : ElevatedButton.icon(
                          onPressed: () => resetCurrShoot(),
                          icon: const Icon(Icons.clear),
                          label: const Text('Reset'),
                        ),
                ),
                const SizedBox(width: 4),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (updatingShoot.value != null) {
                      await updateShootRecord(
                          updatingShoot.value!,
                          ShootRecord()
                            ..id = updatingShoot.value!.id
                            ..missed = true
                            ..dateTime = updatingShoot.value!.dateTime
                            ..hitPositionX = 0
                            ..hitPositionY = 0
                            ..hitTarget = false);
                    } else {
                      await addShootRecord(
                        ShootRecord()
                          ..missed = true
                          ..dateTime = DateTime.now()
                          ..hitPositionX = 0
                          ..hitPositionY = 0
                          ..hitTarget = false,
                        shootRounds.length - 1,
                      );
                    }
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text('Miss'),
                ),
                const SizedBox(width: 4),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (updatingShoot.value != null) {
                      await updateShootRecord(updatingShoot.value!, currShoot.value!);
                    } else {
                      if (currShoot.value?.hitPositionX != null && currShoot.value?.hitPositionY != null) {
                        await addShootRecord(
                          currShoot.value!,
                          shootRounds.length - 1,
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.done),
                  label: const Text('Save'),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Text('Hit Record'),
                const Spacer(),
                Obx(
                  () => CupertinoSwitch(
                    value: showHitPoint.value,
                    onChanged: (value) => showHitPoint.value = value,
                  ),
                ),
                const Spacer(),
                const Text('Heatmap'),
                const Spacer(),
                Obx(
                  () => CupertinoSwitch(
                    value: showHeatmap.value,
                    onChanged: (value) => showHeatmap.value = value,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Obx(
                () => ListView.separated(
                  itemCount: shootRounds.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    List<ShootRecord> relatedRecords = shootRounds[index].relatedRecord.toList();
                    relatedRecords.sort((a, b) => a.dateTime.isAfter(b.dateTime) ? 1 : 0);
                    return Card(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Slidable(
                            key: ValueKey(index),
                            closeOnScroll: true,
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.25,
                              children: [
                                SlidableAction(
                                  flex: 2,
                                  onPressed: (context) async {
                                    if (shootRounds[index].shootCount == 0) return;
                                    await removeShootRound(shootRounds[index]);
                                    shootRounds.removeAt(index);
                                  },
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                    value: displayRecords
                                        .where((p0) => relatedRecords.map((e) => e.id).toList().contains(p0.id))
                                        .toList()
                                        .isNotEmpty,
                                    onChanged: (value) async {
                                      var idList = displayRecords.map((e) => e.id).toList();
                                      if (value!) {
                                        for (int i = 0; i < relatedRecords.length; i++) {
                                          if (!idList.contains(relatedRecords[i].id)) {
                                            displayRecords.add(relatedRecords[i]);
                                          }
                                        }
                                      } else {
                                        for (int i = 0; i < relatedRecords.length; i++) {
                                          if (idList.contains(relatedRecords[i].id)) {
                                            displayRecords.removeAt(displayRecords
                                                .indexWhere((element) => element.id == relatedRecords[i].id));
                                          }
                                        }
                                      }

                                      await updateHeatMap();
                                      setState(() {});
                                    }),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('Round ' + (index + 1).toString()),
                                          Text('Hit Rate ' +
                                              (shootRounds[index].shootCount > 0
                                                  ? ((shootRounds[index].hitCount / shootRounds[index].shootCount * 100)
                                                          .toStringAsFixed(0) +
                                                      '%')
                                                  : '---'))
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          for (int i = 0; i < 4; i++)
                                            i < relatedRecords.length
                                                ? Obx(
                                                    () => InkWell(
                                                      onTap: updatingShoot.value == null
                                                          ? () {
                                                              showHeatmap.value = false;
                                                              if (!relatedRecords[i].missed) {
                                                                displayRecords.removeAt(displayRecords.indexWhere(
                                                                    (element) => element.id == relatedRecords[i].id));
                                                              }
                                                              updatingShoot.value = relatedRecords[i];
                                                              currShoot.value = relatedRecords[i];
                                                            }
                                                          : null,
                                                      child: SizedBox(
                                                        width: 30,
                                                        height: 30,
                                                        child: Center(
                                                          child: relatedRecords[i].missed
                                                              ? const Icon(
                                                                  Icons.remove,
                                                                  color: Colors.grey,
                                                                )
                                                              : relatedRecords[i].hitTarget
                                                                  ? const FaIcon(
                                                                      FontAwesomeIcons.circle,
                                                                      color: Colors.blue,
                                                                    )
                                                                  : const Icon(
                                                                      Icons.close,
                                                                      color: Colors.red,
                                                                    ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Obx(() => InkWell(
                                                      onTap: updatingShoot.value == null
                                                          ? () async {
                                                              if (currShoot.value?.hitPositionX != null &&
                                                                  currShoot.value?.hitPositionY != null) {
                                                                await addShootRecord(
                                                                  currShoot.value!,
                                                                  index,
                                                                );
                                                              }
                                                            }
                                                          : null,
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                                          border: Border.all(color: Colors.blue),
                                                        ),
                                                        child: const Icon(
                                                          Icons.add,
                                                          color: Colors.blue,
                                                          size: 16,
                                                        ),
                                                      ),
                                                    ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
