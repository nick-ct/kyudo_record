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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseController _databaseController = Get.find();

  double paintArea = Get.width * 0.95 > 500 ? 500 : Get.width * 0.95;
  late double deductPosition = paintArea / 2;
  double diameter = Get.width * 0.65 > 325 ? 325 : Get.width * 0.65;
  late double radius = diameter / 2;

  int heatmapWidth = 350;

  Rx<DateTime> currDate = DateTime.now().obs;
  ShootHistory? shootHistory;
  RxList<ShootRound> shootRounds = <ShootRound>[].obs;
  RxList<ShootRecord> displayRecords = <ShootRecord>[].obs;
  Rxn<ShootRecord> currShoot = Rxn<ShootRecord>();
  ShootRecord? updatingRecord;

  Uint8List? heatmapBytes;
  Rx<bool> showHitPoint = true.obs;
  Rx<bool> showHeatmap = true.obs;

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  bool testHitTarget(double? x, double? y) => sqrt(pow(x ?? 0.0, 2) + pow(y ?? 0.0, 2)) < (radius / deductPosition);

  void resetCurrShoot() => currShoot.value = null;

  Future<void> loadHistory() async {
    shootHistory = await _databaseController.getShootHistoryByDate(
        '${currDate.value.year.toString()}-${currDate.value.month.toString().padLeft(2, '0')}-${currDate.value.day.toString().padLeft(2, '0')}');

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

      await updateHeatMap();

      if (shootHistory!.totalShoot % 4 == 0) {
        newRound();
      }
    } else {
      shootHistory = ShootHistory()
        ..date =
            '${currDate.value.year.toString()}-${currDate.value.month.toString().padLeft(2, '0')}-${currDate.value.day.toString().padLeft(2, '0')}'
        ..totalRound = 0
        ..totalShoot = 0
        ..totalHitTarget = 0;
      newRound();
    }
  }

  void newRound() {
    ShootRound newRound = ShootRound()
      ..dateTime = DateTime.now()
      ..shootCount = 0
      ..hitCount = 0;
    shootRounds.add(newRound);
    shootHistory?.relatedRound.add(newRound);
    shootHistory?.totalRound += 1;
  }

  Future<void> addShootRecord(ShootRecord? shootRecord) async {
    await _databaseController.addShootRecord(shootRecord!);
    //update Round
    ShootRound currRound = shootRounds.last;
    if (shootRecord.hitTarget) currRound.hitCount += 1;
    currRound.shootCount += 1;
    currRound.relatedRecord.add(shootRecord);
    await _databaseController.addShootRound(currRound);

    //update History
    if (shootRecord.hitTarget) shootHistory?.totalHitTarget += 1;
    shootHistory?.totalShoot += 1;
    await _databaseController.addShootHistory(shootHistory!);

    //check round
    if (shootRounds.last.shootCount == 4) {
      newRound();
    }

    if (!shootRecord.missed) {
      displayRecords.add(shootRecord);
      await updateHeatMap();
    }

    resetCurrShoot();

    setState(() {});
  }

  Future<void> updateHeatMap() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () async {
                  currDate.value = currDate.value.subtract(const Duration(days: 1));
                  reset();

                  await loadHistory();
                },
                icon: const Icon(Icons.arrow_back)),
            Obx(() => Text(
                '${currDate.value.year.toString()}-${currDate.value.month.toString().padLeft(2, '0')}-${currDate.value.day.toString().padLeft(2, '0')}')),
            IconButton(
                onPressed: () async {
                  currDate.value = currDate.value.add(const Duration(days: 1));
                  reset();

                  await loadHistory();
                },
                icon: const Icon(Icons.arrow_forward)),
          ],
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () => _databaseController.cleanDatabase(),
        //     icon: const Icon(Icons.remove),
        //   ),
        // ],
      ),
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

                  if (updatingRecord != null) {
                    currShoot.value?.id = updatingRecord!.id;
                    currShoot.value?.dateTime = updatingRecord!.dateTime;
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
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.bullseye,
                  size: 40,
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (updatingRecord != null) {
                      await addShootRecord(ShootRecord()
                        ..id = updatingRecord!.id
                        ..missed = true
                        ..dateTime = updatingRecord!.dateTime
                        ..hitPositionX = 0
                        ..hitPositionY = 0
                        ..hitTarget = false);
                    } else {
                      await addShootRecord(ShootRecord()
                        ..missed = true
                        ..dateTime = DateTime.now()
                        ..hitPositionX = 0
                        ..hitPositionY = 0
                        ..hitTarget = false);
                    }
                  },
                  icon: const Icon(Icons.remove),
                  label: const Text('Miss'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () => resetCurrShoot(),
                  icon: const Icon(Icons.delete),
                  label: const Text('Clear'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (currShoot.value?.hitPositionX != null && currShoot.value?.hitPositionY != null) {
                      await addShootRecord(currShoot.value);
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
                    onChanged: (value) => showHeatmap.value = (heatmapBytes == null ? false : value),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: shootRounds.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      List<ShootRecord> relatedRecords = shootRounds[index].relatedRecord.toList();
                      relatedRecords.sort((a, b) => a.dateTime.isAfter(b.dateTime) ? 1 : 0);
                      return Card(
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
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
                                          ? SizedBox(
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
                                            )
                                          : Container(
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
                                            )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
