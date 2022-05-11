import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kyudo_record/controller/shoot_controller.dart';
import 'package:kyudo_record/views/framework.dart';
import 'package:kyudo_record/views/shoot_record/shoot_record_list.dart';
import 'package:kyudo_record/views/shoot_record/shoot_record_mato.dart';
import 'package:kyudo_record/views/shoot_record/shoot_record_summary.dart';

class ShootRecordPage extends StatefulWidget {
  const ShootRecordPage({Key? key}) : super(key: key);

  @override
  State<ShootRecordPage> createState() => _ShootRecordPageState();
}

class _ShootRecordPageState extends State<ShootRecordPage> {
  final ShootController _shootController = Get.find();
  final Rx<int> _selectedIndex = 0.obs;

  @override
  void dispose() {
    _shootController.updateDate(DateTime.now());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Framework(
      appbar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  DateTime newDate = _shootController.currDate.value.subtract(const Duration(days: 1));
                  _shootController.updateDate(newDate);
                },
                icon: const Icon(Icons.arrow_back)),
            Obx(() => Text(_shootController.currDateString())),
            IconButton(
                onPressed: () {
                  DateTime newDate = _shootController.currDate.value.add(const Duration(days: 1));
                  _shootController.updateDate(newDate);
                },
                icon: const Icon(Icons.arrow_forward)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: _shootController.currDate.value,
                firstDate: DateTime(2020, 01),
                lastDate: DateTime(2100, 12),
              );

              if (selectedDate != null) {
                _shootController.updateDate(selectedDate);
              }
            },
          ),
        ],
      ),
      body: Scaffold(
        body: GetBuilder<ShootController>(
          init: _shootController,
          builder: (controller) {
            switch (_selectedIndex.value) {
              case 0:
                return ShootRecordMato(key: Key(controller.currDate.value.toString()));
              case 1:
                return ShootRecordList(key: Key(controller.currDate.value.toString()));
              case 2:
                return ShootRecordSummary(key: Key(controller.currDate.value.toString()));
              default:
                return Container();
            }
          },
        ),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: _selectedIndex.value,
            onDestinationSelected: (index) {
              _selectedIndex.value = index;
              _shootController.update();
            },
            destinations: const [
              NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.bullseye),
                label: 'Mato',
              ),
              NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.listUl),
                label: 'List',
              ),
              NavigationDestination(
                icon: Icon(Icons.summarize),
                label: 'Summary',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
