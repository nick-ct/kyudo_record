import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MatoSize {
  metre17,
  metre28,
  metre60,
}

class Mato {
  MatoSize matoSize = MatoSize.metre28;
  late double diameter = Get.width * 0.65 > 325 ? 325 : Get.width * 0.65;
  late double radius = diameter / 2;

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

  Widget drawMato() {
    switch (matoSize) {
      case MatoSize.metre17:
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: diameter,
              height: diameter,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: diameter * (14.7 / 15),
              height: diameter * (14.7 / 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: diameter * (11.7 / 15),
              height: diameter * (11.7 / 15),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: diameter * (10.2 / 15),
              height: diameter * (10.2 / 15),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: diameter * (7.2 / 15),
              height: diameter * (7.2 / 15),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: diameter * (3.6 / 15),
              height: diameter * (3.6 / 15),
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
              width: diameter,
              height: diameter,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: diameter * (15 / 18),
              height: diameter * (15 / 18),
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
        );
      case MatoSize.metre60:
        return Container();
      default:
        return Container();
    }
  }
}
