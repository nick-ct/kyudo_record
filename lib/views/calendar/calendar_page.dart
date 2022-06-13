import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kyudo_record/controller/database_controller.dart';
import 'package:kyudo_record/models/calendar_data.dart';
import 'package:kyudo_record/models/shoot_history.dart';
import 'package:kyudo_record/views/framework.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final Rx<int> _selectedIndex = 0.obs;
  final DatabaseController _databaseController = Get.find();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  final List<CalendarData> _regularCalendarData = [];
  final List<CalendarData> _eventCalendarData = [];
  List<CalendarData> _selectedDayEventData = [];

  List<ShootHistory> _currMonthShootHistory = [];
  int maxShootCount = 0;

  @override
  void initState() {
    super.initState();

    _databaseController.getAllCalenderData().then((value) {
      if (value != null && mounted) {
        _regularCalendarData.addAll(value.where((element) => element.repeat).toList());
        _eventCalendarData.addAll(value.where((element) => !element.repeat).toList());
        _selectedDayEventData = getCalenderDataByDate(_selectedDay);
      }
    });

    getShootHistory(_selectedDay);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  List<CalendarData> getCalenderDataByDate(DateTime dateTime) {
    final List<CalendarData> result = [];
    result.addAll(_regularCalendarData.where((element) => element.dayOfWeek == dateTime.weekday));
    result.addAll(_eventCalendarData.where((element) =>
        element.eventDate ==
        '${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}'));
    result.sort((a, b) => a.startTime.compareTo(b.startTime));
    return result;
  }

  Future<void> getShootHistory(DateTime dateTime) async {
    _currMonthShootHistory = await _databaseController
        .getShootHistoryByMonth('${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}');
    _currMonthShootHistory.sort((a, b) => a.totalShoot < b.totalShoot ? 1 : 0);
    maxShootCount = _currMonthShootHistory.isNotEmpty ? _currMonthShootHistory.first.totalShoot : 0;
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
                _selectedDayEventData = getCalenderDataByDate(selectedDay);
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
              eventLoader: (day) => getCalenderDataByDate(day),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const Center(child: Text('射箭數')),
                    const Divider(),
                    Obx(() {
                      switch (_selectedIndex.value) {
                        case 0:
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: _selectedDayEventData.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(_selectedDayEventData[index].title),
                                  subtitle: Text(DateFormat('y-MM-dd (EEE)').format(_selectedDay) +
                                      ' ${_selectedDayEventData[index].startTime}-${_selectedDayEventData[index].endTime}'),
                                ),
                              );
                            },
                          );
                        case 1:
                          return Column(
                            children: [
                              Text(
                                DateFormat('y MMMM').format(_selectedDay),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          );
                        default:
                          return Container();
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 64,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: _selectedIndex.value,
            onDestinationSelected: (index) {
              _selectedIndex.value = index;
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.calendar_today),
                label: 'Calendar',
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
