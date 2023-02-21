import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingController extends GetxController {
  late int clusterSensitiveLevel;

  Future<void> init() async {
    final box = GetStorage();
    if (box.read('clusterSensitive') != null) {
      clusterSensitiveLevel = box.read('clusterSensitive');
    } else {
      clusterSensitiveLevel = 250;
      box.writeIfNull('clusterSensitive', 250);
    }
  }
}
