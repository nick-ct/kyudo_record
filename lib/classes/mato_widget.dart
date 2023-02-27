import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyudo_record/models/shoot_record.dart';

enum MatoSize {
  metre17,
  metre28,
  metre60,
}

class Mato {
  MatoSize matoSize = MatoSize.metre28;

  late double paintArea = Get.width * 0.95 > 500 ? 500 : Get.width * 0.95;
  late double deductPosition = paintArea / 2;
  late double diameter = Get.width * 0.65 > 325 ? 325 : Get.width * 0.65;
  late double radius = diameter / 2;

  RxList<ShootRecord> displayRecords = <ShootRecord>[].obs;

  bool testHitTarget(double? x, double? y) => sqrt(pow(x ?? 0.0, 2) + pow(y ?? 0.0, 2)) < radius;

  updateMatoSize(MatoSize newMatoSize) {
    switch (newMatoSize) {
      case MatoSize.metre17:
        matoSize = MatoSize.metre17;
        diameter = Get.width * 0.65 * (5 / 6) > 325 * (5 / 6) ? 325 * (5 / 6) : Get.width * 0.65 * (5 / 6);
        radius = diameter / 2;
        break;
      case MatoSize.metre28:
        matoSize = MatoSize.metre28;
        diameter = Get.width * 0.65 > 325 ? 325 : Get.width * 0.65;
        radius = diameter / 2;
        break;
      case MatoSize.metre60:
        break;
    }
  }

  void setDisplayRecrod(List<ShootRecord> newDisplayRecords) {
    displayRecords.clear();
    displayRecords.addAll(newDisplayRecords);
  }

  Widget drawMato({double scale = 1.0}) {
    double scaledPaintArea = paintArea * scale;
    double scaledDiameter = diameter * scale;

    return Container(
      width: scaledPaintArea,
      height: scaledPaintArea,
      decoration: BoxDecoration(color: Colors.brown[400]),
      child: Center(
        child: mato(scaledDiameter),
      ),
    );
  }

  Widget drawMatoWithDisplay({double scale = 1.0}) {
    double scaledPaintArea = paintArea * scale;
    double scaledDeductPosition = deductPosition * scale;
    double scaledDiameter = diameter * scale;

    return Container(
      width: scaledPaintArea,
      height: scaledPaintArea,
      decoration: BoxDecoration(color: Colors.brown[400]),
      child: Stack(
        alignment: Alignment.center,
        children: [
          mato(scaledDiameter),
          ...displayRecord(scaledDeductPosition, 48 * scale),
        ],
      ),
    );
  }

  Widget mato(double scaledDiameter) {
    switch (matoSize) {
      case MatoSize.metre17:
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: scaledDiameter,
              height: scaledDiameter,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: scaledDiameter * (14.7 / 15),
              height: scaledDiameter * (14.7 / 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: scaledDiameter * (11.7 / 15),
              height: scaledDiameter * (11.7 / 15),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: scaledDiameter * (10.2 / 15),
              height: scaledDiameter * (10.2 / 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: scaledDiameter * (7.2 / 15),
              height: scaledDiameter * (7.2 / 15),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: scaledDiameter * (3.6 / 15),
              height: scaledDiameter * (3.6 / 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ],
        );
      case MatoSize.metre28:
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: scaledDiameter,
              height: scaledDiameter,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: scaledDiameter * (15 / 18),
              height: scaledDiameter * (15 / 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: scaledDiameter * (11.7 / 18),
              height: scaledDiameter * (11.7 / 18),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: scaledDiameter * (10.2 / 18),
              height: scaledDiameter * (10.2 / 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: scaledDiameter * (7.2 / 18),
              height: scaledDiameter * (7.2 / 18),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: scaledDiameter * (3.6 / 18),
              height: scaledDiameter * (3.6 / 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ],
        );
      case MatoSize.metre60:
        return Container();
      default:
        return Container();
    }
  }

  List<Widget> displayRecord(double scaledDeductPosition, double iconsize) {
    return displayRecords
        .where((p0) => !p0.missed)
        .map((record) => Positioned(
              top: record.hitPositionY * scaledDeductPosition * -1 + scaledDeductPosition - 12,
              left: record.hitPositionX * scaledDeductPosition + scaledDeductPosition - 12,
              child: SizedBox(
                height: 24,
                width: 24,
                child: Center(
                  child: Icon(
                    Icons.close,
                    color: Colors.green,
                    size: iconsize,
                  ),
                ),
              ),
            ))
        .toList();
  }
}
