import 'package:isar/isar.dart';

part 'calendar_data.g.dart';

@Collection()
class CalendarData {
  @Id()
  int id = Isar.autoIncrement;
  late String refId;
  late bool repeat;
  late int dayOfWeek;
  late String eventDate;
  late String startTime;
  late String endTime;
  late String title;
  late String location;
  late String remark;
}
