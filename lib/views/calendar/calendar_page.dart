import 'package:flutter/material.dart';
import 'package:kyudo_record/views/framework.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Framework(
      appbar: AppBar(
        centerTitle: true,
      ),
      body: Scaffold(
        body: TableCalendar(
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
            if (day.isAtSameMomentAs(DateTime(2022, 05, 25))) {
              return [const Event('event')];
            }
            if (day.weekday == DateTime.monday) {
              return [const Event('Cyclic event')];
            }

            return [];
          },
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
