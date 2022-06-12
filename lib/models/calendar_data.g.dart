// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_data.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetCalendarDataCollection on Isar {
  IsarCollection<CalendarData> get calendarDatas => getCollection();
}

const CalendarDataSchema = CollectionSchema(
  name: 'CalendarData',
  schema:
      '{"name":"CalendarData","idName":"id","properties":[{"name":"dayOfWeek","type":"Long"},{"name":"endTime","type":"String"},{"name":"eventDate","type":"String"},{"name":"location","type":"String"},{"name":"refId","type":"String"},{"name":"remark","type":"String"},{"name":"repeat","type":"Bool"},{"name":"startTime","type":"String"},{"name":"title","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {
    'dayOfWeek': 0,
    'endTime': 1,
    'eventDate': 2,
    'location': 3,
    'refId': 4,
    'remark': 5,
    'repeat': 6,
    'startTime': 7,
    'title': 8
  },
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _calendarDataGetId,
  setId: _calendarDataSetId,
  getLinks: _calendarDataGetLinks,
  attachLinks: _calendarDataAttachLinks,
  serializeNative: _calendarDataSerializeNative,
  deserializeNative: _calendarDataDeserializeNative,
  deserializePropNative: _calendarDataDeserializePropNative,
  serializeWeb: _calendarDataSerializeWeb,
  deserializeWeb: _calendarDataDeserializeWeb,
  deserializePropWeb: _calendarDataDeserializePropWeb,
  version: 3,
);

int? _calendarDataGetId(CalendarData object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _calendarDataSetId(CalendarData object, int id) {
  object.id = id;
}

List<IsarLinkBase> _calendarDataGetLinks(CalendarData object) {
  return [];
}

void _calendarDataSerializeNative(
    IsarCollection<CalendarData> collection,
    IsarRawObject rawObj,
    CalendarData object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.dayOfWeek;
  final _dayOfWeek = value0;
  final value1 = object.endTime;
  final _endTime = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_endTime.length) as int;
  final value2 = object.eventDate;
  final _eventDate = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_eventDate.length) as int;
  final value3 = object.location;
  final _location = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_location.length) as int;
  final value4 = object.refId;
  final _refId = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_refId.length) as int;
  final value5 = object.remark;
  final _remark = IsarBinaryWriter.utf8Encoder.convert(value5);
  dynamicSize += (_remark.length) as int;
  final value6 = object.repeat;
  final _repeat = value6;
  final value7 = object.startTime;
  final _startTime = IsarBinaryWriter.utf8Encoder.convert(value7);
  dynamicSize += (_startTime.length) as int;
  final value8 = object.title;
  final _title = IsarBinaryWriter.utf8Encoder.convert(value8);
  dynamicSize += (_title.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _dayOfWeek);
  writer.writeBytes(offsets[1], _endTime);
  writer.writeBytes(offsets[2], _eventDate);
  writer.writeBytes(offsets[3], _location);
  writer.writeBytes(offsets[4], _refId);
  writer.writeBytes(offsets[5], _remark);
  writer.writeBool(offsets[6], _repeat);
  writer.writeBytes(offsets[7], _startTime);
  writer.writeBytes(offsets[8], _title);
}

CalendarData _calendarDataDeserializeNative(
    IsarCollection<CalendarData> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = CalendarData();
  object.dayOfWeek = reader.readLong(offsets[0]);
  object.endTime = reader.readString(offsets[1]);
  object.eventDate = reader.readString(offsets[2]);
  object.id = id;
  object.location = reader.readString(offsets[3]);
  object.refId = reader.readString(offsets[4]);
  object.remark = reader.readString(offsets[5]);
  object.repeat = reader.readBool(offsets[6]);
  object.startTime = reader.readString(offsets[7]);
  object.title = reader.readString(offsets[8]);
  return object;
}

P _calendarDataDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _calendarDataSerializeWeb(
    IsarCollection<CalendarData> collection, CalendarData object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'dayOfWeek', object.dayOfWeek);
  IsarNative.jsObjectSet(jsObj, 'endTime', object.endTime);
  IsarNative.jsObjectSet(jsObj, 'eventDate', object.eventDate);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'location', object.location);
  IsarNative.jsObjectSet(jsObj, 'refId', object.refId);
  IsarNative.jsObjectSet(jsObj, 'remark', object.remark);
  IsarNative.jsObjectSet(jsObj, 'repeat', object.repeat);
  IsarNative.jsObjectSet(jsObj, 'startTime', object.startTime);
  IsarNative.jsObjectSet(jsObj, 'title', object.title);
  return jsObj;
}

CalendarData _calendarDataDeserializeWeb(
    IsarCollection<CalendarData> collection, dynamic jsObj) {
  final object = CalendarData();
  object.dayOfWeek =
      IsarNative.jsObjectGet(jsObj, 'dayOfWeek') ?? double.negativeInfinity;
  object.endTime = IsarNative.jsObjectGet(jsObj, 'endTime') ?? '';
  object.eventDate = IsarNative.jsObjectGet(jsObj, 'eventDate') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.location = IsarNative.jsObjectGet(jsObj, 'location') ?? '';
  object.refId = IsarNative.jsObjectGet(jsObj, 'refId') ?? '';
  object.remark = IsarNative.jsObjectGet(jsObj, 'remark') ?? '';
  object.repeat = IsarNative.jsObjectGet(jsObj, 'repeat') ?? false;
  object.startTime = IsarNative.jsObjectGet(jsObj, 'startTime') ?? '';
  object.title = IsarNative.jsObjectGet(jsObj, 'title') ?? '';
  return object;
}

P _calendarDataDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'dayOfWeek':
      return (IsarNative.jsObjectGet(jsObj, 'dayOfWeek') ??
          double.negativeInfinity) as P;
    case 'endTime':
      return (IsarNative.jsObjectGet(jsObj, 'endTime') ?? '') as P;
    case 'eventDate':
      return (IsarNative.jsObjectGet(jsObj, 'eventDate') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'location':
      return (IsarNative.jsObjectGet(jsObj, 'location') ?? '') as P;
    case 'refId':
      return (IsarNative.jsObjectGet(jsObj, 'refId') ?? '') as P;
    case 'remark':
      return (IsarNative.jsObjectGet(jsObj, 'remark') ?? '') as P;
    case 'repeat':
      return (IsarNative.jsObjectGet(jsObj, 'repeat') ?? false) as P;
    case 'startTime':
      return (IsarNative.jsObjectGet(jsObj, 'startTime') ?? '') as P;
    case 'title':
      return (IsarNative.jsObjectGet(jsObj, 'title') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _calendarDataAttachLinks(
    IsarCollection col, int id, CalendarData object) {}

extension CalendarDataQueryWhereSort
    on QueryBuilder<CalendarData, CalendarData, QWhere> {
  QueryBuilder<CalendarData, CalendarData, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension CalendarDataQueryWhere
    on QueryBuilder<CalendarData, CalendarData, QWhereClause> {
  QueryBuilder<CalendarData, CalendarData, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterWhereClause> idNotEqualTo(
      int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<CalendarData, CalendarData, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<CalendarData, CalendarData, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<CalendarData, CalendarData, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension CalendarDataQueryFilter
    on QueryBuilder<CalendarData, CalendarData, QFilterCondition> {
  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      dayOfWeekEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'dayOfWeek',
      value: value,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      dayOfWeekGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'dayOfWeek',
      value: value,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      dayOfWeekLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'dayOfWeek',
      value: value,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      dayOfWeekBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'dayOfWeek',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      endTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'endTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      endTimeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'endTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      endTimeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'endTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      endTimeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'endTime',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      endTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'endTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      endTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'endTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      endTimeContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'endTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      endTimeMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'endTime',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      eventDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'eventDate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      eventDateGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'eventDate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      eventDateLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'eventDate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      eventDateBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'eventDate',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      eventDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'eventDate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      eventDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'eventDate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      eventDateContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'eventDate',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      eventDateMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'eventDate',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      locationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'location',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      locationGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'location',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      locationLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'location',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      locationBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'location',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      locationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'location',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      locationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'location',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      locationContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'location',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      locationMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'location',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> refIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'refId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      refIdGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'refId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> refIdLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'refId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> refIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'refId',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      refIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'refId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> refIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'refId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> refIdContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'refId',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> refIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'refId',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> remarkEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'remark',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      remarkGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'remark',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      remarkLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'remark',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> remarkBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'remark',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      remarkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'remark',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      remarkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'remark',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      remarkContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'remark',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> remarkMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'remark',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> repeatEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'repeat',
      value: value,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      startTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'startTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      startTimeGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'startTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      startTimeLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'startTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      startTimeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'startTime',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      startTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'startTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      startTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'startTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      startTimeContains(String value, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'startTime',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      startTimeMatches(String pattern, {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'startTime',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> titleLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'title',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'title',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<CalendarData, CalendarData, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'title',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension CalendarDataQueryLinks
    on QueryBuilder<CalendarData, CalendarData, QFilterCondition> {}

extension CalendarDataQueryWhereSortBy
    on QueryBuilder<CalendarData, CalendarData, QSortBy> {
  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByDayOfWeek() {
    return addSortByInternal('dayOfWeek', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByDayOfWeekDesc() {
    return addSortByInternal('dayOfWeek', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByEndTime() {
    return addSortByInternal('endTime', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByEndTimeDesc() {
    return addSortByInternal('endTime', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByEventDate() {
    return addSortByInternal('eventDate', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByEventDateDesc() {
    return addSortByInternal('eventDate', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByLocation() {
    return addSortByInternal('location', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByLocationDesc() {
    return addSortByInternal('location', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByRefId() {
    return addSortByInternal('refId', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByRefIdDesc() {
    return addSortByInternal('refId', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByRemark() {
    return addSortByInternal('remark', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByRemarkDesc() {
    return addSortByInternal('remark', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByRepeat() {
    return addSortByInternal('repeat', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByRepeatDesc() {
    return addSortByInternal('repeat', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByStartTime() {
    return addSortByInternal('startTime', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByStartTimeDesc() {
    return addSortByInternal('startTime', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> sortByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }
}

extension CalendarDataQueryWhereSortThenBy
    on QueryBuilder<CalendarData, CalendarData, QSortThenBy> {
  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByDayOfWeek() {
    return addSortByInternal('dayOfWeek', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByDayOfWeekDesc() {
    return addSortByInternal('dayOfWeek', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByEndTime() {
    return addSortByInternal('endTime', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByEndTimeDesc() {
    return addSortByInternal('endTime', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByEventDate() {
    return addSortByInternal('eventDate', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByEventDateDesc() {
    return addSortByInternal('eventDate', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByLocation() {
    return addSortByInternal('location', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByLocationDesc() {
    return addSortByInternal('location', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByRefId() {
    return addSortByInternal('refId', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByRefIdDesc() {
    return addSortByInternal('refId', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByRemark() {
    return addSortByInternal('remark', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByRemarkDesc() {
    return addSortByInternal('remark', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByRepeat() {
    return addSortByInternal('repeat', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByRepeatDesc() {
    return addSortByInternal('repeat', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByStartTime() {
    return addSortByInternal('startTime', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByStartTimeDesc() {
    return addSortByInternal('startTime', Sort.desc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByTitle() {
    return addSortByInternal('title', Sort.asc);
  }

  QueryBuilder<CalendarData, CalendarData, QAfterSortBy> thenByTitleDesc() {
    return addSortByInternal('title', Sort.desc);
  }
}

extension CalendarDataQueryWhereDistinct
    on QueryBuilder<CalendarData, CalendarData, QDistinct> {
  QueryBuilder<CalendarData, CalendarData, QDistinct> distinctByDayOfWeek() {
    return addDistinctByInternal('dayOfWeek');
  }

  QueryBuilder<CalendarData, CalendarData, QDistinct> distinctByEndTime(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('endTime', caseSensitive: caseSensitive);
  }

  QueryBuilder<CalendarData, CalendarData, QDistinct> distinctByEventDate(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('eventDate', caseSensitive: caseSensitive);
  }

  QueryBuilder<CalendarData, CalendarData, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<CalendarData, CalendarData, QDistinct> distinctByLocation(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('location', caseSensitive: caseSensitive);
  }

  QueryBuilder<CalendarData, CalendarData, QDistinct> distinctByRefId(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('refId', caseSensitive: caseSensitive);
  }

  QueryBuilder<CalendarData, CalendarData, QDistinct> distinctByRemark(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('remark', caseSensitive: caseSensitive);
  }

  QueryBuilder<CalendarData, CalendarData, QDistinct> distinctByRepeat() {
    return addDistinctByInternal('repeat');
  }

  QueryBuilder<CalendarData, CalendarData, QDistinct> distinctByStartTime(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('startTime', caseSensitive: caseSensitive);
  }

  QueryBuilder<CalendarData, CalendarData, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('title', caseSensitive: caseSensitive);
  }
}

extension CalendarDataQueryProperty
    on QueryBuilder<CalendarData, CalendarData, QQueryProperty> {
  QueryBuilder<CalendarData, int, QQueryOperations> dayOfWeekProperty() {
    return addPropertyNameInternal('dayOfWeek');
  }

  QueryBuilder<CalendarData, String, QQueryOperations> endTimeProperty() {
    return addPropertyNameInternal('endTime');
  }

  QueryBuilder<CalendarData, String, QQueryOperations> eventDateProperty() {
    return addPropertyNameInternal('eventDate');
  }

  QueryBuilder<CalendarData, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<CalendarData, String, QQueryOperations> locationProperty() {
    return addPropertyNameInternal('location');
  }

  QueryBuilder<CalendarData, String, QQueryOperations> refIdProperty() {
    return addPropertyNameInternal('refId');
  }

  QueryBuilder<CalendarData, String, QQueryOperations> remarkProperty() {
    return addPropertyNameInternal('remark');
  }

  QueryBuilder<CalendarData, bool, QQueryOperations> repeatProperty() {
    return addPropertyNameInternal('repeat');
  }

  QueryBuilder<CalendarData, String, QQueryOperations> startTimeProperty() {
    return addPropertyNameInternal('startTime');
  }

  QueryBuilder<CalendarData, String, QQueryOperations> titleProperty() {
    return addPropertyNameInternal('title');
  }
}
