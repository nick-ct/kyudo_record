import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kyudo_record/network.dart';
import 'package:kyudo_record/views/framework.dart';
import 'package:http/http.dart' as http;

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
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Set sync event calendar url'),
                    IconButton(
                      icon: const Icon(Icons.input),
                      onPressed: () async {
                        TextEditingController _textFieldController =
                            TextEditingController(text: box.read('syncUrl') ?? '');
                        String url = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Sync Event Calendar'),
                                content: TextField(
                                  controller: _textFieldController,
                                  decoration: const InputDecoration(hintText: "Input Url Here"),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('CANCEL'),
                                    onPressed: () => Get.back(result: ''),
                                  ),
                                  ElevatedButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Get.back(result: _textFieldController.text);
                                    },
                                  ),
                                ],
                              );
                            });

                        if (await checkEventCalendarUrlValid(url)) {
                          box.write('syncUrl', url);
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
