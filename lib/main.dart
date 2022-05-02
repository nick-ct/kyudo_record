import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    deductPosition = Get.width * 0.95 / 2;
    radius = Get.width * 0.65 / 2;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  bool testHitTarget(double x, double y) => sqrt(pow(x, 2) + pow(y, 2)) < (radius / deductPosition);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: GestureDetector(
          onTapDown: (tapDownDetails) {
            print('x - deductPosition ' + (tapDownDetails.localPosition.dx - deductPosition).toString());
            print('y - deductPosition ' + ((tapDownDetails.localPosition.dy - deductPosition) * -1).toString());
            var newPoint = Offset(
              ((tapDownDetails.localPosition.dx - deductPosition) / deductPosition),
              ((tapDownDetails.localPosition.dy - deductPosition) * -1 / deductPosition),
            );
            print('testHitTarget ' + testHitTarget(newPoint.dx, newPoint.dy).toString());
          },
          child: Container(
            width: Get.width * 0.95,
            height: Get.width * 0.95,
            decoration: BoxDecoration(color: Colors.brown[400]),
            child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
