import 'package:get/get.dart';
import 'package:isar/isar.dart';
import 'package:kyudo_record/models/calendar_data.dart';
import 'package:kyudo_record/models/shoot_history.dart';
import 'package:kyudo_record/models/shoot_record.dart';
import 'package:kyudo_record/models/shoot_round.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseController extends GetxController {
  late Isar isar;

  Future<void> init() async {
    final dir = await getApplicationSupportDirectory();
    isar = await Isar.open(
      schemas: [ShootRecordSchema, ShootRoundSchema, ShootHistorySchema, CalendarDataSchema],
      directory: dir.path,
      inspector: true,
    );
  }

  Future<int?> addShootRecord(ShootRecord data) async {
    int? recId;
    await isar.writeTxn((isar) async {
      recId = await isar.shootRecords.put(
        data,
        replaceOnConflict: true,
        saveLinks: true,
      );
    });
    return recId;
  }

  Future<void> removeShootRecord(ShootRecord data) async {
    await isar.writeTxn((isar) async {
      await isar.shootRecords.delete(data.id);
    });
  }

  Future<int?> addShootRound(ShootRound data) async {
    int? recId;
    await isar.writeTxn((isar) async {
      recId = await isar.shootRounds.put(
        data,
        replaceOnConflict: true,
        saveLinks: true,
      );
    });
    return recId;
  }

  Future<void> removeShootRound(ShootRound data) async {
    await isar.writeTxn((isar) async {
      await isar.shootRounds.delete(data.id);
    });
  }

  Future<int?> addShootHistory(ShootHistory data) async {
    int? recId;
    await isar.writeTxn((isar) async {
      recId = await isar.shootHistorys.put(
        data,
        replaceOnConflict: true,
        saveLinks: true,
      );
    });
    return recId;
  }

  Future<ShootHistory?> getShootHistoryByDate(String date) async {
    final result = await isar.shootHistorys.where().dateEqualTo(date).findAll();
    return result.isEmpty ? null : result.first;
  }

  Future<int?> addCalenderData(CalendarData data) async {
    int? recId;
    await isar.writeTxn((isar) async {
      recId = await isar.calendarDatas.put(
        data,
        replaceOnConflict: true,
        saveLinks: true,
      );
    });
    return recId;
  }

  Future<List<CalendarData>?> getAllCalenderDataByDate(DateTime date) async {
    final List<CalendarData> result = [];
    result.addAll(await isar.calendarDatas
        .where()
        .eventDateEqualTo(
            '${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}')
        .findAll());
    result.addAll(await isar.calendarDatas.where().dayOfWeekEqualTo(date.weekday).findAll());
    return result;
  }

  Future<void> removeCalenderData(CalendarData data) async {
    await isar.writeTxn((isar) async {
      await isar.calendarDatas.delete(data.id);
    });
  }

  void loadCalenderData(Map json) async {
    isar.writeTxn((isar) async {
      await isar.calendarDatas.clear();
    });

    var regular = json['regular'] as List;
    for (int i = 0; i < regular.length; i++) {
      print(regular[i].toString());
      await addCalenderData(CalendarData()
        ..refId = regular[i]['refId']
        ..repeat = regular[i]['repeat']
        ..eventDate = ''
        ..dayOfWeek = regular[i]['dayOfWeek']
        ..startTime = regular[i]['startTime']
        ..endTime = regular[i]['endTime']
        ..title = regular[i]['title']
        ..location = regular[i]['location']
        ..remark = regular[i]['remark']);
    }
    var event = json['event'] as List;
    for (int i = 0; i < event.length; i++) {
      print(event[i].toString());
      await addCalenderData(CalendarData()
        ..refId = event[i]['refId']
        ..repeat = event[i]['repeat']
        ..eventDate = event[i]['eventDate']
        ..dayOfWeek = 0
        ..startTime = event[i]['startTime']
        ..endTime = event[i]['endTime']
        ..title = event[i]['title']
        ..location = event[i]['location']
        ..remark = event[i]['remark']);
    }
  }

  void cleanDatabase() {
    isar.writeTxn((isar) async {
      await isar.shootHistorys.clear();
      await isar.shootRounds.clear();
      await isar.shootRecords.clear();
      await isar.calendarDatas.clear();
    });
  }
}
