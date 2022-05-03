import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_heat_map/flutter_heat_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double paintArea;
  late double deductPosition;
  late double radius;
  late double diameter;
  int heatmapWidth = 350;

  RxList<Offset> points = <Offset>[].obs;
  Rxn<Offset> newPoint = Rxn<Offset>();
  Uint8List? bytes;
  Rx<bool> showHitPoint = true.obs;
  Rx<bool> showHeatmap = false.obs;

  @override
  void initState() {
    super.initState();
    paintArea = Get.width * 0.95 > 500 ? 500 : Get.width * 0.95;
    deductPosition = paintArea / 2;
    diameter = Get.width * 0.65 > 325 ? 325 : Get.width * 0.65;
    radius = diameter / 2;
  }

  bool testHitTarget(double? x, double? y) => sqrt(pow(x ?? 0.0, 2) + pow(y ?? 0.0, 2)) < (radius / deductPosition);

  void savePoint() {
    if (newPoint.value != null) {
      points.add(newPoint.value!);
      newPoint.value = null;
    }
  }

  Future<void> createHeatMap() async {
    if (points.isEmpty) return;
    showHeatmap.value = false;

    ImageProvider? provider =
        AssetImage('assets/images/transparent' + heatmapWidth.toString() + 'x' + heatmapWidth.toString() + '.png');
    ui.Image? image = await HeatMap.imageProviderToUiImage(provider);

    HeatMapPage heatMapPage = HeatMapPage(
      image: image,
      events: points
          .map((element) => HeatMapEvent(
                  location: Offset(
                (element.dx * heatmapWidth / 2 + heatmapWidth / 2),
                (element.dy * heatmapWidth / 2 * -1 + heatmapWidth / 2),
              )))
          .toList(),
    );
    bytes = await HeatMap.process(heatMapPage);

    showHeatmap.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: Get.width,
            width: Get.width,
            child: Center(
              child: GestureDetector(
                onTapDown: (tapDownDetails) {
                  // print('x ' + (tapDownDetails.localPosition.dx).toString());
                  // print('y ' + (tapDownDetails.localPosition.dy).toString());
                  // print('x - deductPosition ' + (tapDownDetails.localPosition.dx - deductPosition).toString());
                  // print('y - deductPosition ' + ((tapDownDetails.localPosition.dy - deductPosition) * -1).toString());
                  newPoint.value = Offset(
                    ((tapDownDetails.localPosition.dx - deductPosition) / deductPosition),
                    ((tapDownDetails.localPosition.dy - deductPosition) * -1 / deductPosition),
                  );
                  // print(newPoint.value?.dx);
                  // print(newPoint.value?.dy);
                  // print((newPoint.value?.dx ?? 0.0) * deductPosition + deductPosition);
                  // print((newPoint.value?.dy ?? 0.0) * deductPosition * -1 + deductPosition);
                  // print('testHitTarget ' + testHitTarget(newPoint.value?.dx, newPoint.value?.dy).toString());
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
                        if (newPoint.value != null)
                          Positioned(
                            top: (newPoint.value?.dy ?? 0.0) * deductPosition * -1 + deductPosition - 12,
                            left: (newPoint.value?.dx ?? 0.0) * deductPosition + deductPosition - 12,
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
                        if (showHitPoint.value)
                          ...points
                              .map((point) => Positioned(
                                    top: point.dy * deductPosition * -1 + deductPosition - 12,
                                    left: point.dx * deductPosition + deductPosition - 12,
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
                        if (showHeatmap.value)
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Image.memory(
                              bytes!,
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
          TextButton(
            onPressed: () => savePoint(),
            child: const Text('save new point'),
          ),
          TextButton(
            onPressed: () => newPoint.value = null,
            child: const Text('clear new point'),
          ),
          TextButton(
            onPressed: () async => await createHeatMap(),
            child: const Text('create heatmap'),
          ),
          TextButton(
            onPressed: () => showHitPoint.value = !showHitPoint.value,
            child: const Text('switch hit point'),
          ),
          TextButton(
            onPressed: () => showHeatmap.value = !showHeatmap.value,
            child: const Text('switch heatmap point'),
          ),
          Obx(() => Wrap(
                children: points.map((element) {
                  bool hitTarget = testHitTarget(element.dx, element.dy);
                  return Icon(
                    hitTarget ? Icons.circle_outlined : Icons.close,
                    color: hitTarget ? Colors.blue : Colors.red,
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }
}
