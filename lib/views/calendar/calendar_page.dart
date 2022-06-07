import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyudo_record/controller/database_controller.dart';
import 'package:kyudo_record/models/calendar_data.dart';
import 'package:kyudo_record/views/framework.dart';
import 'package:table_calendar/table_calendar.dart';

final testjsonstr = '''{
  "regular": [
    {
      "refId": "reg_1",
      "repeat": true,
      "dayOfWeek": 1,
      "startTime": "20:00",
      "endTime": "22:00",
      "title": "加操練習",
      "location": "道場",
      "remark": ""
    },
    {
      "refId": "reg_2",
      "repeat": true,
      "dayOfWeek": 3,
      "startTime": "20:00",
      "endTime": "22:00",
      "title": "課堂學習",
      "location": "道場",
      "remark": ""
    },
    {
      "refId": "reg_3",
      "repeat": true,
      "dayOfWeek": 5,
      "startTime": "20:00",
      "endTime": "22:00",
      "title": "加操練習",
      "location": "道場",
      "remark": ""
    },
    {
      "refId": "reg_4",
      "repeat": true,
      "dayOfWeek": 6,
      "startTime": "17:30",
      "endTime": "19:30",
      "title": "課堂學習",
      "location": "道場",
      "remark": ""
    },
    {
      "refId": "reg_5",
      "repeat": true,
      "dayOfWeek": 6,
      "startTime": "20:00",
      "endTime": "22:00",
      "title": "加操練習",
      "location": "道場",
      "remark": ""
    }
  ],
  "event": [
    {
      "refId": "event_1",
      "repeat": false,
      "eventDate": "2022-06-03",
      "startTime": "15:00",
      "endTime": "19:00",
      "title": "2週年",
      "location": "道場",
      "remark": ""
    },
    {
      "refId": "event_2",
      "repeat": false,
      "eventDate": "2022-07-01",
      "startTime": "16:00",
      "endTime": "19:00",
      "title": "佰射會",
      "location": "道場",
      "remark": ""
    }
  ]
}''';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final DatabaseController _databaseController = Get.find();
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  List<CalendarData> regularCalendarData = [];
  List<CalendarData> eventCalendarData = [];

  @override
  void initState() {
    super.initState();

    _databaseController.loadCalenderData(jsonDecode(testjsonstr));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
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
              focusedDay: _focusedDay,
              daysOfWeekHeight: 24,
              firstDay: DateTime.utc(2020, 1),
              lastDay: DateTime.utc(2100, 1),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = selectedDay;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              eventLoader: (day) {
                var eventList = [];
                _databaseController.getAllCalenderDataByDate(day);
                if (day.isAtSameMomentAs(DateTime(2022, 06, 20))) {
                  eventList.add(const Event('event'));
                }
                if (day.weekday == DateTime.monday) {
                  eventList.add(const Event('Cyclic event'));
                }

                return eventList;
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    child: Text('2'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}
