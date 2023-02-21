import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_heat_map/flutter_heat_map.dart';
import 'package:kyudo_record/controller/setting_controller.dart';
import 'package:kyudo_record/controller/shoot_controller.dart';
import 'package:kyudo_record/models/shoot_record.dart';
import 'package:kyudo_record/models/shoot_round.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kyudo_record/classes/mato_widget.dart';

class ShootRecordMato extends StatefulWidget {
  const ShootRecordMato({Key? key}) : super(key: key);

  @override
  State<ShootRecordMato> createState() => _ShootRecordMatoState();
}

class _ShootRecordMatoState extends State<ShootRecordMato> with TickerProviderStateMixin {
  final SettingController _settingController = Get.find();
  final ShootController _shootController = Get.find();

  late double paintArea = Get.width * 0.95 > 500 ? 500 : Get.width * 0.95;
  late double deductPosition = paintArea / 2;

  Mato mato = Mato();
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

    displayRecords.clear();
    resetCurrShoot();
    resetUpdatingShoot();
    heatmapBytes = null;
    showHitPoint.value = true;
    showHeatmap.value = true;

    for (int i = 0; i < _shootController.shootRounds.length; i++) {
      List<ShootRecord> relatedRecords = _shootController.shootRounds[i].relatedRecord.toList();
      relatedRecords.sort((a, b) => a.dateTime.isAfter(b.dateTime) ? 1 : 0);
      displayRecords.addAll(relatedRecords.where((element) => !element.missed));
    }

    mato.updateMatoSize(MatoSize.values[_shootController.shootRounds.last.matoSize]);

    await updateHeatMap();

    if (mounted) setState(() {});
  }

  void resetCurrShoot() => currShoot.value = null;

  void resetUpdatingShoot() => updatingShoot.value = null;

  Future<void> addShootRecord(ShootRecord shootRecord, int round) async {
    await _shootController.addShootRecord(shootRecord, round);

    if (!shootRecord.missed) {
      displayRecords.add(shootRecord);
      await updateHeatMap();
    }

    resetCurrShoot();

    setState(() {});
  }

  Future<void> updateShootRecord(ShootRecord originalShootRecord, ShootRecord newShootRecord) async {
    await _shootController.updateShootRecord(originalShootRecord, newShootRecord);

    if (!newShootRecord.missed) {
      displayRecords.add(newShootRecord);
    }

    await resetScreen();
  }

  Future<void> removeShootRecord(ShootRecord shootRecord) async {
    await _shootController.removeShootRecord(shootRecord);

    await resetScreen();
  }

  Future<void> updateMatoSize(MatoSize matoSize, ShootRound shootRound) async {
    _shootController.updateMatoSize(matoSize);
    mato.updateMatoSize(matoSize);

    await _shootController.updateRoundMatoSize(matoSize, shootRound);

    mato.updateMatoSize(MatoSize.values[_shootController.shootRounds.last.matoSize]);
    setState(() {});
  }

  Future<void> removeShootRound(ShootRound shootRound) async {
    for (int i = 0; i < shootRound.relatedRecord.length; i++) {
      displayRecords
          .removeAt(displayRecords.indexWhere((element) => element.id == shootRound.relatedRecord.toList()[i].id));
    }
    await _shootController.removeShootRound(shootRound);

    await resetScreen();
  }

  Future<void> updateHeatMap() async {
    if (displayRecords.isEmpty) {
      heatmapBytes = null;
      return;
    }
    ImageProvider? provider =
        AssetImage('assets/images/transparent' + _settingController.clusterSensitiveLevel.toStringAsFixed(0) + '.png');
    ui.Image? image = await HeatMap.imageProviderToUiImage(provider);

    HeatMapPage heatMapPage = HeatMapPage(
      image: image,
      events: displayRecords
          .map((element) => HeatMapEvent(
                  location: Offset(
                (element.hitPositionX * _settingController.clusterSensitiveLevel / 2 +
                    _settingController.clusterSensitiveLevel / 2),
                (element.hitPositionY * _settingController.clusterSensitiveLevel / 2 * -1 +
                    _settingController.clusterSensitiveLevel / 2),
              )))
          .toList(),
    );
    heatmapBytes = await HeatMap.process(heatMapPage);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        _shootController.shootRounds.length - 1,
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
                          _shootController.shootRounds.length - 1,
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
                  itemCount: _shootController.shootRounds.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    MatoSize matoSize = MatoSize.values[_shootController.shootRounds[index].matoSize];
                    List<ShootRecord> relatedRecords = _shootController.shootRounds[index].relatedRecord.toList();
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
                                      builder: (ctx) => InkWell(
                                        onTap: () async {
                                          Slidable.of(ctx)?.close();
                                          await removeShootRound(_shootController.shootRounds[index]);
                                          _shootController.shootRounds.removeAt(index);

                                          if (_shootController.shootRounds.isEmpty ||
                                              _shootController.shootRounds.last.shootCount == 4) {
                                            _shootController.newShootRound();
                                          }
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
                                            const Text('28M'),
                                            Text('Hit Rate ' +
                                                (_shootController.shootRounds[index].shootCount > 0
                                                    ? ((_shootController.shootRounds[index].hitCount /
                                                                _shootController.shootRounds[index].shootCount *
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
                                  Builder(
                                    builder: (ctx) => IconButton(
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () => Slidable.of(ctx)?.openEndActionPane(),
                                    ),
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
