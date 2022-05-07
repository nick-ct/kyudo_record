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
import 'package:kyudo_record/classes/mato_widget.dart';

class ShootRecordMato extends StatefulWidget {
  final String currDate;
  const ShootRecordMato({Key? key, required this.currDate}) : super(key: key);

  @override
  State<ShootRecordMato> createState() => _ShootRecordMatoState();
}

class _ShootRecordMatoState extends State<ShootRecordMato> with TickerProviderStateMixin {
  final DatabaseController _databaseController = Get.find();

  late double paintArea = Get.width * 0.95 > 500 ? 500 : Get.width * 0.95;
  late double deductPosition = paintArea / 2;

  int heatmapWidth = 350;
  MatoSize currMatoSize = MatoSize.metre28;

  Mato mato = Mato();
  ShootHistory? shootHistory;
  RxList<ShootRound> shootRounds = <ShootRound>[].obs;
  RxList<ShootRecord> displayRecords = <ShootRecord>[].obs;
  Rxn<ShootRecord> currShoot = Rxn<ShootRecord>();
  MatoSize? originalMatoSize;
  Rxn<ShootRecord> updatingShoot = Rxn<ShootRecord>();
  Rxn<ShootRecord> highlightShoot = Rxn<ShootRecord>();

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

      if (shootRounds.isEmpty || shootRounds.last.shootCount == 4) {
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
      ..matoSize = currMatoSize.index
      ..hitCount = 0;
    shootRounds.add(newShootRound);
    shootHistory?.relatedRound.add(newShootRound);
    shootHistory?.totalRound += 1;
  }

  Future<void> updateMatoSize(MatoSize matoSize, ShootRound shootRound) async {
    mato.updateMatoSize(matoSize);
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

    mato.updateMatoSize(MatoSize.values[shootRounds.last.matoSize]);
    setState(() {});
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
            height: paintArea,
            width: paintArea,
            child: Center(
              child: GestureDetector(
                onTapDown: (tapDownDetails) {
                  currShoot.value = ShootRecord()
                    ..missed = false
                    ..dateTime = DateTime.now()
                    ..hitPositionX = (tapDownDetails.localPosition.dx - deductPosition) / deductPosition
                    ..hitPositionY = (tapDownDetails.localPosition.dy - deductPosition) * -1 / deductPosition
                    ..hitTarget = mato.testHitTarget(
                      (tapDownDetails.localPosition.dx - deductPosition),
                      (tapDownDetails.localPosition.dy - deductPosition) * -1,
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
                        mato.drawMato(),
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
                                    child: SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Center(
                                        child: Icon(
                                          Icons.close,
                                          color: (highlightShoot.value != null && highlightShoot.value == record)
                                              ? Colors.yellow
                                              : Colors.green,
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        //display heatmap
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
                        //highlight record
                        if (highlightShoot.value != null)
                          Positioned(
                            top: highlightShoot.value!.hitPositionY * deductPosition * -1 + deductPosition - 15,
                            left: highlightShoot.value!.hitPositionX * deductPosition + deductPosition - 15,
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.yellow,
                                ),
                              ),
                            ),
                          )
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
                PopupMenuButton<MatoSize>(
                  offset: const Offset(30, 30),
                  icon: const FaIcon(FontAwesomeIcons.bullseye),
                  iconSize: 40,
                  onSelected: (matoSize) => updateMatoSize(matoSize, shootRounds.last),
                  itemBuilder: (BuildContext context) {
                    return [
                      CheckedPopupMenuItem(
                        checked: mato.matoSize == MatoSize.metre17,
                        child: const Text('17M'),
                        value: MatoSize.metre17,
                      ),
                      CheckedPopupMenuItem(
                        checked: mato.matoSize == MatoSize.metre28,
                        child: const Text('28M'),
                        value: MatoSize.metre28,
                      ),
                    ];
                  },
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

                      mato.updateMatoSize(originalMatoSize!);
                      setState(() {});
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

                      mato.updateMatoSize(originalMatoSize!);
                      setState(() {});
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
                  label: Obx(() => updatingShoot.value != null ? const Text('Save') : const Text('Add')),
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
                    MatoSize matoSize = MatoSize.values[shootRounds[index].matoSize];
                    List<ShootRecord> relatedRecords = shootRounds[index].relatedRecord.toList();
                    relatedRecords.sort((a, b) => a.dateTime.isAfter(b.dateTime) ? 1 : 0);
                    return Card(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SlidableAutoCloseBehavior(
                            child: Slidable(
                              closeOnScroll: true,
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                extentRatio: 0.4,
                                children: [
                                  Expanded(
                                    child: Builder(
                                      builder: (ctx) => PopupMenuButton<MatoSize>(
                                        offset: const Offset(30, 30),
                                        child: Container(
                                          color: Colors.yellow[900],
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        onSelected: (matoSize) async {
                                          await updateMatoSize(matoSize, shootRounds[index]);
                                          Slidable.of(ctx)?.close();
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return [
                                            CheckedPopupMenuItem(
                                              checked: matoSize == MatoSize.metre17,
                                              child: const Text('17M'),
                                              value: MatoSize.metre17,
                                            ),
                                            CheckedPopupMenuItem(
                                              checked: matoSize == MatoSize.metre28,
                                              child: const Text('28M'),
                                              value: MatoSize.metre28,
                                            ),
                                          ];
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Builder(
                                      builder: (ctx) => InkWell(
                                        onTap: () async {
                                          Slidable.of(ctx)?.close();
                                          await removeShootRound(shootRounds[index]);
                                          shootRounds.removeAt(index);

                                          if (shootRounds.isEmpty || shootRounds.last.shootCount == 4) newShootRound();
                                        },
                                        child: Container(
                                          color: Colors.grey,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
                                            Text(matoSize == MatoSize.metre17
                                                ? '17M'
                                                : matoSize == MatoSize.metre28
                                                    ? '28M'
                                                    : ''),
                                            Text('Hit Rate ' +
                                                (shootRounds[index].shootCount > 0
                                                    ? ((shootRounds[index].hitCount /
                                                                shootRounds[index].shootCount *
                                                                100)
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
                                                                originalMatoSize = mato.matoSize;
                                                                mato.updateMatoSize(matoSize);
                                                                setState(() {});
                                                                showHeatmap.value = false;

                                                                if (!relatedRecords[i].missed) {
                                                                  displayRecords.removeAt(displayRecords.indexWhere(
                                                                      (element) => element.id == relatedRecords[i].id));
                                                                }
                                                                updatingShoot.value = relatedRecords[i];
                                                                currShoot.value = relatedRecords[i];
                                                              }
                                                            : null,
                                                        onLongPress: () async {
                                                          bool originalShowHeatmap = showHeatmap.value;

                                                          showHeatmap.value = false;
                                                          highlightShoot.value = relatedRecords[i];
                                                          await Future.delayed(const Duration(seconds: 1));
                                                          highlightShoot.value = null;
                                                          showHeatmap.value = originalShowHeatmap;
                                                        },
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
