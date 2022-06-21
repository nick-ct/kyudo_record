import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kyudo_record/controller/database_controller.dart';
import 'package:kyudo_record/network.dart';

class SettingController extends GetxController {
  final DatabaseController _databaseController = Get.find();
  late int clusterSensitiveLevel;

  Future<void> init() async {
    final box = GetStorage();
    if (box.read('clusterSensitive') != null) {
      clusterSensitiveLevel = box.read('clusterSensitive');
    } else {
      clusterSensitiveLevel = 250;
      box.writeIfNull('clusterSensitive', 250);
    }

    if (box.read('syncUrl') != null) {
      _databaseController.loadCalenderData(await getEventCalendarUrlData(box.read('syncUrl')));
    }
  }
}
