import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kyudo_record/views/framework.dart';
import 'package:kyudo_record/views/shoot_record/shoot_record_mato.dart';
import 'package:kyudo_record/views/shoot_record/shoot_record_summary.dart';

class ShootRecordPage extends StatefulWidget {
  const ShootRecordPage({Key? key}) : super(key: key);

  @override
  State<ShootRecordPage> createState() => _ShootRecordPageState();
}

class _ShootRecordPageState extends State<ShootRecordPage> {
  final Rx<int> _selectedIndex = 0.obs;
  Rx<DateTime> currDate = DateTime.now().obs;

  void _onItemTapped(int index) => _selectedIndex.value = index;

  String currDateString(DateTime dateTime) =>
      '${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Framework(
      appbar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () => currDate.value = currDate.value.subtract(const Duration(days: 1)),
                icon: const Icon(Icons.arrow_back)),
            Obx(() => Text(
                '${currDate.value.year.toString()}-${currDate.value.month.toString().padLeft(2, '0')}-${currDate.value.day.toString().padLeft(2, '0')}')),
            IconButton(
                onPressed: () => currDate.value = currDate.value.add(const Duration(days: 1)),
                icon: const Icon(Icons.arrow_forward)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: currDate.value,
                firstDate: DateTime(2020, 01),
                lastDate: DateTime(2100, 12),
              );

              if (selectedDate != null) {
                currDate.value = selectedDate;
              }
            },
          ),
        ],
      ),
      body: Scaffold(
        body: Obx(
          () => _selectedIndex.value == 0
              ? ShootRecordMato(key: Key(currDateString(currDate.value)), currDate: currDateString(currDate.value))
              : const ShootRecordSummary(),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.bullseye),
                label: 'Mato',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.summarize),
                label: 'Summary',
              ),
            ],
            currentIndex: _selectedIndex.value,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
