import 'package:isar/isar.dart';

part 'calendar_data.g.dart';

@Collection()
class CalendarData {
  @Id()
  int id = Isar.autoIncrement;
  @Index()
  late String refId;
  late bool repeat;
  @Index()
  late int dayOfWeek;
  @Index()
  late String eventDate;
  late String startTime;
  late String endTime;
  late String title;
  late String location;
  late String remark;
}
