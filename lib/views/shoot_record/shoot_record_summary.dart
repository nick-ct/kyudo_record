import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyudo_record/classes/mato_widget.dart';
import 'package:kyudo_record/classes/shoot_record_summary_data.dart';
import 'package:kyudo_record/controller/shoot_controller.dart';
import 'package:kyudo_record/models/shoot_record.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:lottie/lottie.dart';

class ShootRecordSummary extends StatefulWidget {
  const ShootRecordSummary({Key? key}) : super(key: key);
  @override
  _ShootRecordSummaryState createState() => _ShootRecordSummaryState();
}

class _ShootRecordSummaryState extends State<ShootRecordSummary> {
  final ShootController _shootController = Get.find();
  late double paintArea = Get.width * 0.95 > 500 ? 500 : Get.width * 0.95;
  late double deductPosition = paintArea / 2;

  final Rx<bool> loading = false.obs;
  List<String> labels = [];
  List<ShootRecordSummaryData> summaryData = [];
  final Rx<int> _selectedIndex = 0.obs;
  final List<String> availableLabels = ['17M', '28M', '60M'];

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    loading.value = true;

    for (int i = 0; i < MatoSize.values.length; i++) {
      var _roundList = _shootController.shootRounds.where((p0) => p0.matoSize == i).toList();
      if (_roundList.isNotEmpty) {
        labels.add(availableLabels[i]);
        ShootRecordSummaryData newSummaryData = ShootRecordSummaryData();
        newSummaryData.setMatoSize(MatoSize.values[i]);
        for (int i = 0; i < _roundList.length; i++) {
          List<ShootRecord> relatedRecords = _roundList[i].relatedRecord.toList();
          newSummaryData.displayRecords.addAll(relatedRecords.where((element) => !element.missed));
        }
        await newSummaryData.updateHeatMap();
        summaryData.add(newSummaryData);
      }
    }

    if (mounted) setState(() {});
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => loading.value
          ? Center(
              child: Lottie.asset(
                'assets/lottie/loading.json',
                width: 200,
                height: 200,
                fit: BoxFit.scaleDown,
              ),
            )
          : _shootController.shootHistory?.totalShoot == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/lottie/empty-box.json',
                        width: 200,
                        height: 200,
                        fit: BoxFit.scaleDown,
                        repeat: false,
                      ),
                      const Text('No Data'),
                    ],
                  ),
                )
              : Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      width: Get.width,
                      child: Center(
                        child: ToggleSwitch(
                          minWidth: Get.width / labels.length,
                          animate: true,
                          animationDuration: 500,
                          initialLabelIndex: 0,
                          totalSwitches: labels.length,
                          labels: labels,
                          onToggle: (index) => _selectedIndex.value = index!,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: paintArea,
                      width: paintArea,
                      child: Center(
                        child: Obx(
                          () => Container(
                            width: paintArea,
                            height: paintArea,
                            decoration: BoxDecoration(color: Colors.brown[400]),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                //Mato Widget List
                                summaryData[_selectedIndex.value].mato.drawMato(),
                                //display record
                                ...summaryData[_selectedIndex.value]
                                    .displayRecords
                                    .where((p0) => !p0.missed)
                                    .map((record) => Positioned(
                                          top: record.hitPositionY * deductPosition * -1 + deductPosition - 12,
                                          left: record.hitPositionX * deductPosition + deductPosition - 12,
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
                                //display heatmap
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Image.memory(
                                    summaryData[_selectedIndex.value].heatmapBytes!,
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
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      width: Get.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total Hit Count'),
                              _shootController.shootHistory!.totalShoot > 0
                                  ? Text(
                                      '${_shootController.shootHistory?.totalHitTarget} / ${_shootController.shootHistory?.totalShoot} (' +
                                          (_shootController.shootHistory!.totalHitTarget /
                                                  _shootController.shootHistory!.totalShoot *
                                                  100)
                                              .toStringAsFixed(2) +
                                          ' %)')
                                  : const Text('0 / 0 (0.00 %)'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
