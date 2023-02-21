import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kyudo_record/views/framework.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final box = GetStorage();
  final RxDouble _currentSliderValue = 250.0.obs;

  @override
  void initState() {
    super.initState();
    _currentSliderValue.value = double.tryParse(box.read('clusterSensitive').toString())!;
  }

  @override
  Widget build(BuildContext context) {
    return Framework(
      appbar: AppBar(
        centerTitle: true,
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Cluster Sensitive'),
                    Obx(() => Text(_currentSliderValue.value.toStringAsFixed(0))),
                  ],
                ),
              ),
              Obx(
                () => Slider(
                  value: _currentSliderValue.value,
                  max: 2000,
                  min: 50,
                  divisions: 39,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    _currentSliderValue.value = value;
                  },
                  onChangeEnd: (double value) {
                    box.write('clusterSensitive', int.tryParse(value.toStringAsFixed(0)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
