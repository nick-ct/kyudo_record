import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_heat_map/flutter_heat_map.dart';
import 'package:get/get.dart';
import 'package:kyudo_record/classes/mato_widget.dart';
import 'package:kyudo_record/controller/setting_controller.dart';
import 'package:kyudo_record/models/shoot_record.dart';
import 'package:kyudo_record/models/shoot_round.dart';

class ShootRecordSummaryData {
  final SettingController _settingController = Get.find();
  Mato mato = Mato();

  List<ShootRound> roundList = [];

  List<ShootRecord> firstShoot = [];
  List<ShootRecord> secondShoot = [];
  List<ShootRecord> thirdShoot = [];
  List<ShootRecord> fourthShoot = [];

  RxList<ShootRecord> displayRecords = <ShootRecord>[].obs;
  Uint8List? heatmapBytes;

  void setMatoSize(MatoSize matoSize) => mato.updateMatoSize(matoSize);

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
}
