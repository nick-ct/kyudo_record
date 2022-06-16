import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_heat_map/flutter_heat_map.dart';
import 'package:get/get.dart';
import 'package:kyudo_record/classes/mato_widget.dart';
import 'package:kyudo_record/models/shoot_record.dart';
import 'package:kyudo_record/models/shoot_round.dart';

class ShootRecordSummaryData {
  Mato mato = Mato();

  List<ShootRound> roundList = [];

  List<ShootRecord> firstShoot = [];
  List<ShootRecord> secondShoot = [];
  List<ShootRecord> thirdShoot = [];
  List<ShootRecord> fourthShoot = [];

  RxList<ShootRecord> displayRecords = <ShootRecord>[].obs;
  Uint8List? heatmapBytes;
  int heatmapWidth = 350;

  void setMatoSize(MatoSize matoSize) => mato.updateMatoSize(matoSize);

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
}
