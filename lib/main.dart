import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_heat_map/flutter_heat_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double deductPosition;
  late double radius;
  int heatmapWidth = 500;

  RxList<Offset> points = <Offset>[].obs;
  Rxn<Offset> newPoint = Rxn<Offset>();
  Uint8List? bytes;
  Rx<bool> showHitPoint = true.obs;
  Rx<bool> showHeatmap = false.obs;

  @override
  void initState() {
    super.initState();
    deductPosition = Get.width * 0.95 / 2;
    radius = Get.width * 0.65 / 2;
  }

  bool testHitTarget(double? x, double? y) => sqrt(pow(x ?? 0.0, 2) + pow(y ?? 0.0, 2)) < (radius / deductPosition);

  void savePoint() {
    if (newPoint.value != null) {
      points.add(newPoint.value!);
      newPoint.value = null;
    }
  }

  Future<void> createHeatMap() async {
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
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: savePoint,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: Get.width * 0.05 / 2),
            GestureDetector(
              onTapDown: (tapDownDetails) {
                print('x ' + (tapDownDetails.localPosition.dx).toString());
                print('y ' + (tapDownDetails.localPosition.dy).toString());
                print('x - deductPosition ' + (tapDownDetails.localPosition.dx - deductPosition).toString());
                print('y - deductPosition ' + ((tapDownDetails.localPosition.dy - deductPosition) * -1).toString());
                newPoint.value = Offset(
                  ((tapDownDetails.localPosition.dx - deductPosition) / deductPosition),
                  ((tapDownDetails.localPosition.dy - deductPosition) * -1 / deductPosition),
                );
                print(newPoint.value?.dx);
                print(newPoint.value?.dy);
                print((newPoint.value?.dx ?? 0.0) * deductPosition + deductPosition);
                print((newPoint.value?.dy ?? 0.0) * deductPosition * -1 + deductPosition);
                print('testHitTarget ' + testHitTarget(newPoint.value?.dx, newPoint.value?.dy).toString());
              },
              child: Obx(
                () => Container(
                  width: Get.width * 0.95,
                  height: Get.width * 0.95,
                  decoration: BoxDecoration(color: Colors.brown[400]),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      //Mato Widget List
                      ...[
                        Container(
                          width: Get.width * 0.65,
                          height: Get.width * 0.65,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: Get.width * 0.65 * (14.7 / 18),
                          height: Get.width * 0.65 * (14.7 / 18),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: Get.width * 0.65 * (11.7 / 18),
                          height: Get.width * 0.65 * (11.7 / 18),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: Get.width * 0.65 * (10.2 / 18),
                          height: Get.width * 0.65 * (10.2 / 18),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: Get.width * 0.65 * (7.2 / 18),
                          height: Get.width * 0.65 * (7.2 / 18),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: Get.width * 0.65 * (3.6 / 18),
                          height: Get.width * 0.65 * (3.6 / 18),
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
                            width: Get.width * 0.95,
                            height: Get.width * 0.95,
                            fit: BoxFit.contain,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.width * 0.05 / 2),
            TextButton(
              onPressed: () async => await createHeatMap(),
              child: const Text('create heatmap'),
            ),
            TextButton(
              onPressed: () => showHitPoint.value = !showHitPoint.value,
              child: const Text('switch hit point'),
            ),
          ],
        ),
      ),
    );
  }
}
