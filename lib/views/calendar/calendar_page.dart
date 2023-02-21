import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kyudo_record/classes/mato_widget.dart';
import 'package:kyudo_record/classes/shoot_record_summary_data.dart';
import 'package:kyudo_record/controller/database_controller.dart';
import 'package:kyudo_record/models/shoot_history.dart';
import 'package:kyudo_record/models/shoot_record.dart';
import 'package:kyudo_record/views/framework.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int _selectedIndex = 0;
  final DatabaseController _databaseController = Get.find();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<ShootHistory> _currMonthShootHistory = [];
  int maxShootCount = 0;

  int totalHit = 0;
  int totalShoot = 0;
  List<ShootRecordSummaryData> summaryData = [];
  final Rx<int> _selectedMatoSize = 0.obs;

  @override
  void initState() {
    super.initState();

    getShootHistory(_selectedDay).then((value) => setState(() {}));
  }

  Future<void> getShootHistory(DateTime dateTime) async {
    totalHit = 0;
    totalShoot = 0;
    summaryData.clear();

    _currMonthShootHistory = await _databaseController
        .getShootHistoryByMonth('${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}');
    _currMonthShootHistory.sort((a, b) => a.totalShoot < b.totalShoot ? 1 : 0);
    maxShootCount = _currMonthShootHistory.isNotEmpty ? _currMonthShootHistory.first.totalShoot : 0;

    for (var _shootHistory in _currMonthShootHistory) {
      totalHit += _shootHistory.totalHitTarget;
      totalShoot += _shootHistory.totalShoot;

      for (int i = 0; i < MatoSize.values.length; i++) {
        await _shootHistory.relatedRound.load();
        if (_shootHistory.relatedRound.where((p0) => p0.matoSize == i).toList().isNotEmpty) {
          ShootRecordSummaryData newSummaryData = summaryData.firstWhere(
            (element) => element.mato.matoSize == MatoSize.values[i],
            orElse: () {
              var newData = ShootRecordSummaryData();
              newData.setMatoSize(MatoSize.values[i]);
              return newData;
            },
          );

          newSummaryData.roundList.addAll(_shootHistory.relatedRound.where((p0) => p0.matoSize == i).toList());

          for (int i = 0; i < newSummaryData.roundList.length; i++) {
            await newSummaryData.roundList[i].relatedRecord.load();
            List<ShootRecord> relatedRecords = newSummaryData.roundList[i].relatedRecord.toList();
            newSummaryData.displayRecords.addAll(relatedRecords.where((element) => !element.missed));
            for (int i = 0; i < relatedRecords.length; i++) {
              switch (i) {
                case 0:
                  newSummaryData.firstShoot.add(relatedRecords[i]);
                  break;
                case 1:
                  newSummaryData.secondShoot.add(relatedRecords[i]);
                  break;
                case 2:
                  newSummaryData.thirdShoot.add(relatedRecords[i]);
                  break;
                case 3:
                  newSummaryData.fourthShoot.add(relatedRecords[i]);
                  break;
              }
            }
          }
          await newSummaryData.updateHeatMap();
          summaryData.add(newSummaryData);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Framework(
      appbar: AppBar(
        centerTitle: true,
      ),
      body: Scaffold(
        body: Column(
          children: [
            TableCalendar(
              headerStyle: const HeaderStyle(titleCentered: true),
              focusedDay: _focusedDay,
              daysOfWeekHeight: 24,
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},
              firstDay: DateTime.utc(2020, 1),
              lastDay: DateTime.utc(2100, 1),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  return Container(
                    color: Colors.red.withOpacity(_currMonthShootHistory
                            .firstWhere((element) => element.date == DateFormat('y-MM-dd').format(day),
                                orElse: () => ShootHistory()..totalShoot = 0)
                            .totalShoot /
                        (maxShootCount == 0 ? 1 : maxShootCount)),
                    child: Center(
                      child: Text(day.day.toString()),
                    ),
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  return Container(
                    color: Colors.red.withOpacity(_currMonthShootHistory
                            .firstWhere((element) => element.date == DateFormat('y-MM-dd').format(day),
                                orElse: () => ShootHistory()..totalShoot = 0)
                            .totalShoot /
                        (maxShootCount == 0 ? 1 : maxShootCount)),
                    child: Center(
                      child: Text(day.day.toString()),
                    ),
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  return Container(
                    color: Colors.red.withOpacity(_currMonthShootHistory
                            .firstWhere((element) => element.date == DateFormat('y-MM-dd').format(day),
                                orElse: () => ShootHistory()..totalShoot = 0)
                            .totalShoot /
                        (maxShootCount == 0 ? 1 : maxShootCount)),
                    child: Center(
                      child: Text(
                        day.day.toString(),
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  );
                },
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) async {
                if (_focusedDay.year != selectedDay.year || _focusedDay.month != selectedDay.month) {
                  await getShootHistory(selectedDay);
                }

                _selectedDay = selectedDay;
                _focusedDay = selectedDay;

                setState(() {});
              },
              onPageChanged: (focusedDay) async {
                if (_focusedDay.year != focusedDay.year || _focusedDay.month != focusedDay.month) {
                  await getShootHistory(focusedDay);
                }

                _focusedDay = focusedDay;

                setState(() {});
              },
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(child: Center(child: Text('0'))),
                Expanded(
                    flex: 4,
                    child: Container(
                      width: Get.width,
                      height: 20,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.red.withOpacity(0),
                          Colors.red.withOpacity(1),
                        ],
                      )),
                    )),
                Expanded(child: Center(child: Text(maxShootCount.toString()))),
              ],
            ),
            const Center(child: Text('Total Shoot')),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            width: Get.width,
                            child: summaryData.isEmpty
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Total Hit Count'),
                                          Text('0 / 0 (0.0 %)'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Hit In 1st Shoot'),
                                          Text('0 / 0 (0.0 %)'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Hit In 2nd Shoot'),
                                          Text('0 / 0 (0.0 %)'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Hit In 3rd Shoot'),
                                          Text('0 / 0 (0.0 %)'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Hit In 4th Shoot'),
                                          Text('0 / 0 (0.0 %)'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('All Miss Shoot Round'),
                                          Text('0'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('1 Hit Shoot Round'),
                                          Text('0'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('2 Hit Shoot Round'),
                                          Text('0'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('3 Hit Shoot Round'),
                                          Text('0'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('All Hit Shoot Round'),
                                          Text('0'),
                                        ],
                                      ),
                                    ],
                                  )
                                : Obx(
                                    () => Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Total Hit Count'),
                                            totalShoot == 0
                                                ? const Text('0 / 0 (0.0 %)')
                                                : Text('$totalHit / $totalShoot (' +
                                                    (totalHit / totalShoot * 100).toStringAsFixed(1) +
                                                    ' %)'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Hit In 1st Shoot'),
                                            summaryData[_selectedMatoSize.value].firstShoot.isEmpty
                                                ? const Text('0 / 0 (0.0 %)')
                                                : Text(
                                                    '${summaryData[_selectedMatoSize.value].firstShoot.where((element) => element.hitTarget).toList().length} / ${summaryData[_selectedMatoSize.value].firstShoot.length} (' +
                                                        (summaryData[_selectedMatoSize.value]
                                                                    .firstShoot
                                                                    .where((element) => element.hitTarget)
                                                                    .toList()
                                                                    .length /
                                                                summaryData[_selectedMatoSize.value].firstShoot.length *
                                                                100)
                                                            .toStringAsFixed(1) +
                                                        ' %)'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Hit In 2nd Shoot'),
                                            summaryData[_selectedMatoSize.value].secondShoot.isEmpty
                                                ? const Text('0 / 0 (0.0 %)')
                                                : Text(
                                                    '${summaryData[_selectedMatoSize.value].secondShoot.where((element) => element.hitTarget).toList().length} / ${summaryData[_selectedMatoSize.value].secondShoot.length} (' +
                                                        (summaryData[_selectedMatoSize.value]
                                                                    .secondShoot
                                                                    .where((element) => element.hitTarget)
                                                                    .toList()
                                                                    .length /
                                                                summaryData[_selectedMatoSize.value]
                                                                    .secondShoot
                                                                    .length *
                                                                100)
                                                            .toStringAsFixed(1) +
                                                        ' %)'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Hit In 3rd Shoot'),
                                            summaryData[_selectedMatoSize.value].thirdShoot.isEmpty
                                                ? const Text('0 / 0 (0.0 %)')
                                                : Text(
                                                    '${summaryData[_selectedMatoSize.value].thirdShoot.where((element) => element.hitTarget).toList().length} / ${summaryData[_selectedMatoSize.value].thirdShoot.length} (' +
                                                        (summaryData[_selectedMatoSize.value]
                                                                    .thirdShoot
                                                                    .where((element) => element.hitTarget)
                                                                    .toList()
                                                                    .length /
                                                                summaryData[_selectedMatoSize.value].thirdShoot.length *
                                                                100)
                                                            .toStringAsFixed(1) +
                                                        ' %)'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Hit In 4th Shoot'),
                                            summaryData[_selectedMatoSize.value].fourthShoot.isEmpty
                                                ? const Text('0 / 0 (0.0 %)')
                                                : Text(
                                                    '${summaryData[_selectedMatoSize.value].fourthShoot.where((element) => element.hitTarget).toList().length} / ${summaryData[_selectedMatoSize.value].fourthShoot.length} (' +
                                                        (summaryData[_selectedMatoSize.value]
                                                                    .fourthShoot
                                                                    .where((element) => element.hitTarget)
                                                                    .toList()
                                                                    .length /
                                                                summaryData[_selectedMatoSize.value]
                                                                    .fourthShoot
                                                                    .length *
                                                                100)
                                                            .toStringAsFixed(1) +
                                                        ' %)'),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('All Miss Shoot Round'),
                                            Text(summaryData[_selectedMatoSize.value]
                                                .roundList
                                                .where((element) => element.hitCount == 0)
                                                .toList()
                                                .length
                                                .toString()),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('1 Hit Shoot Round'),
                                            Text(summaryData[_selectedMatoSize.value]
                                                .roundList
                                                .where((element) => element.hitCount == 1)
                                                .toList()
                                                .length
                                                .toString()),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('2 Hit Shoot Round'),
                                            Text(summaryData[_selectedMatoSize.value]
                                                .roundList
                                                .where((element) => element.hitCount == 2)
                                                .toList()
                                                .length
                                                .toString()),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('3 Hit Shoot Round'),
                                            Text(summaryData[_selectedMatoSize.value]
                                                .roundList
                                                .where((element) => element.hitCount == 3)
                                                .toList()
                                                .length
                                                .toString()),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('All Hit Shoot Round'),
                                            Text(summaryData[_selectedMatoSize.value]
                                                .roundList
                                                .where((element) => element.hitCount == 4)
                                                .toList()
                                                .length
                                                .toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          height: 64,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.summarize),
              label: 'Summary',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_today),
              label: 'Schedule',
            ),
          ],
        ),
      ),
    );
  }
}
