// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoot_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetShootRecordCollection on Isar {
  IsarCollection<ShootRecord> get shootRecords => getCollection();
}

const ShootRecordSchema = CollectionSchema(
  name: 'ShootRecord',
  schema:
      '{"name":"ShootRecord","idName":"id","properties":[{"name":"dateTime","type":"Long"},{"name":"hitPositionX","type":"Double"},{"name":"hitPositionY","type":"Double"},{"name":"hitTarget","type":"Bool"},{"name":"missed","type":"Bool"}],"indexes":[{"name":"dateTime","unique":false,"properties":[{"name":"dateTime","type":"Value","caseSensitive":false}]}],"links":[]}',
  idName: 'id',
  propertyIds: {
    'dateTime': 0,
    'hitPositionX': 1,
    'hitPositionY': 2,
    'hitTarget': 3,
    'missed': 4
  },
  listProperties: {},
  indexIds: {'dateTime': 0},
  indexValueTypes: {
    'dateTime': [
      IndexValueType.long,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _shootRecordGetId,
  setId: _shootRecordSetId,
  getLinks: _shootRecordGetLinks,
  attachLinks: _shootRecordAttachLinks,
  serializeNative: _shootRecordSerializeNative,
  deserializeNative: _shootRecordDeserializeNative,
  deserializePropNative: _shootRecordDeserializePropNative,
  serializeWeb: _shootRecordSerializeWeb,
  deserializeWeb: _shootRecordDeserializeWeb,
  deserializePropWeb: _shootRecordDeserializePropWeb,
  version: 3,
);

int? _shootRecordGetId(ShootRecord object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _shootRecordSetId(ShootRecord object, int id) {
  object.id = id;
}

List<IsarLinkBase> _shootRecordGetLinks(ShootRecord object) {
  return [];
}

void _shootRecordSerializeNative(
    IsarCollection<ShootRecord> collection,
    IsarRawObject rawObj,
    ShootRecord object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.dateTime;
  final _dateTime = value0;
  final value1 = object.hitPositionX;
  final _hitPositionX = value1;
  final value2 = object.hitPositionY;
  final _hitPositionY = value2;
  final value3 = object.hitTarget;
  final _hitTarget = value3;
  final value4 = object.missed;
  final _missed = value4;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDateTime(offsets[0], _dateTime);
  writer.writeDouble(offsets[1], _hitPositionX);
  writer.writeDouble(offsets[2], _hitPositionY);
  writer.writeBool(offsets[3], _hitTarget);
  writer.writeBool(offsets[4], _missed);
}

ShootRecord _shootRecordDeserializeNative(
    IsarCollection<ShootRecord> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ShootRecord();
  object.hitPositionX = reader.readDouble(offsets[1]);
  object.hitPositionY = reader.readDouble(offsets[2]);
  object.hitTarget = reader.readBool(offsets[3]);
  object.id = id;
  object.missed = reader.readBool(offsets[4]);
  return object;
}

P _shootRecordDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _shootRecordSerializeWeb(
    IsarCollection<ShootRecord> collection, ShootRecord object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(
      jsObj, 'dateTime', object.dateTime.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'hitPositionX', object.hitPositionX);
  IsarNative.jsObjectSet(jsObj, 'hitPositionY', object.hitPositionY);
  IsarNative.jsObjectSet(jsObj, 'hitTarget', object.hitTarget);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'missed', object.missed);
  return jsObj;
}

ShootRecord _shootRecordDeserializeWeb(
    IsarCollection<ShootRecord> collection, dynamic jsObj) {
  final object = ShootRecord();
  object.hitPositionX =
      IsarNative.jsObjectGet(jsObj, 'hitPositionX') ?? double.negativeInfinity;
  object.hitPositionY =
      IsarNative.jsObjectGet(jsObj, 'hitPositionY') ?? double.negativeInfinity;
  object.hitTarget = IsarNative.jsObjectGet(jsObj, 'hitTarget') ?? false;
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.missed = IsarNative.jsObjectGet(jsObj, 'missed') ?? false;
  return object;
}

P _shootRecordDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'dateTime':
      return (IsarNative.jsObjectGet(jsObj, 'dateTime') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'dateTime'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    case 'hitPositionX':
      return (IsarNative.jsObjectGet(jsObj, 'hitPositionX') ??
          double.negativeInfinity) as P;
    case 'hitPositionY':
      return (IsarNative.jsObjectGet(jsObj, 'hitPositionY') ??
          double.negativeInfinity) as P;
    case 'hitTarget':
      return (IsarNative.jsObjectGet(jsObj, 'hitTarget') ?? false) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'missed':
      return (IsarNative.jsObjectGet(jsObj, 'missed') ?? false) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _shootRecordAttachLinks(IsarCollection col, int id, ShootRecord object) {}

extension ShootRecordQueryWhereSort
    on QueryBuilder<ShootRecord, ShootRecord, QWhere> {
  QueryBuilder<ShootRecord, ShootRecord, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhere> anyDateTime() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'dateTime'));
  }
}

extension ShootRecordQueryWhere
    on QueryBuilder<ShootRecord, ShootRecord, QWhereClause> {
  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> idBetween(
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

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> dateTimeEqualTo(
      DateTime dateTime) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'dateTime',
      value: [dateTime],
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> dateTimeNotEqualTo(
      DateTime dateTime) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'dateTime',
        upper: [dateTime],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'dateTime',
        lower: [dateTime],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'dateTime',
        lower: [dateTime],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'dateTime',
        upper: [dateTime],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> dateTimeGreaterThan(
    DateTime dateTime, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'dateTime',
      lower: [dateTime],
      includeLower: include,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> dateTimeLessThan(
    DateTime dateTime, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'dateTime',
      upper: [dateTime],
      includeUpper: include,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> dateTimeBetween(
    DateTime lowerDateTime,
    DateTime upperDateTime, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'dateTime',
      lower: [lowerDateTime],
      includeLower: includeLower,
      upper: [upperDateTime],
      includeUpper: includeUpper,
    ));
  }
}

extension ShootRecordQueryFilter
    on QueryBuilder<ShootRecord, ShootRecord, QFilterCondition> {
  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> dateTimeEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'dateTime',
      value: value,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'dateTime',
      value: value,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'dateTime',
      value: value,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'dateTime',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionXGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'hitPositionX',
      value: value,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionXLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'hitPositionX',
      value: value,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionXBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'hitPositionX',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionYGreaterThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: false,
      property: 'hitPositionY',
      value: value,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionYLessThan(double value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: false,
      property: 'hitPositionY',
      value: value,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionYBetween(double lower, double upper) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'hitPositionY',
      lower: lower,
      includeLower: false,
      upper: upper,
      includeUpper: false,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitTargetEqualTo(bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hitTarget',
      value: value,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> missedEqualTo(
      bool value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'missed',
      value: value,
    ));
  }
}

extension ShootRecordQueryLinks
    on QueryBuilder<ShootRecord, ShootRecord, QFilterCondition> {}

extension ShootRecordQueryWhereSortBy
    on QueryBuilder<ShootRecord, ShootRecord, QSortBy> {
  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByDateTime() {
    return addSortByInternal('dateTime', Sort.asc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByDateTimeDesc() {
    return addSortByInternal('dateTime', Sort.desc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByHitPositionX() {
    return addSortByInternal('hitPositionX', Sort.asc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy>
      sortByHitPositionXDesc() {
    return addSortByInternal('hitPositionX', Sort.desc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByHitPositionY() {
    return addSortByInternal('hitPositionY', Sort.asc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy>
      sortByHitPositionYDesc() {
    return addSortByInternal('hitPositionY', Sort.desc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByHitTarget() {
    return addSortByInternal('hitTarget', Sort.asc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByHitTargetDesc() {
    return addSortByInternal('hitTarget', Sort.desc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByMissed() {
    return addSortByInternal('missed', Sort.asc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByMissedDesc() {
    return addSortByInternal('missed', Sort.desc);
  }
}

extension ShootRecordQueryWhereSortThenBy
    on QueryBuilder<ShootRecord, ShootRecord, QSortThenBy> {
  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByDateTime() {
    return addSortByInternal('dateTime', Sort.asc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByDateTimeDesc() {
    return addSortByInternal('dateTime', Sort.desc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByHitPositionX() {
    return addSortByInternal('hitPositionX', Sort.asc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy>
      thenByHitPositionXDesc() {
    return addSortByInternal('hitPositionX', Sort.desc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByHitPositionY() {
    return addSortByInternal('hitPositionY', Sort.asc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy>
      thenByHitPositionYDesc() {
    return addSortByInternal('hitPositionY', Sort.desc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByHitTarget() {
    return addSortByInternal('hitTarget', Sort.asc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByHitTargetDesc() {
    return addSortByInternal('hitTarget', Sort.desc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByMissed() {
    return addSortByInternal('missed', Sort.asc);
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByMissedDesc() {
    return addSortByInternal('missed', Sort.desc);
  }
}

extension ShootRecordQueryWhereDistinct
    on QueryBuilder<ShootRecord, ShootRecord, QDistinct> {
  QueryBuilder<ShootRecord, ShootRecord, QDistinct> distinctByDateTime() {
    return addDistinctByInternal('dateTime');
  }

  QueryBuilder<ShootRecord, ShootRecord, QDistinct> distinctByHitPositionX() {
    return addDistinctByInternal('hitPositionX');
  }

  QueryBuilder<ShootRecord, ShootRecord, QDistinct> distinctByHitPositionY() {
    return addDistinctByInternal('hitPositionY');
  }

  QueryBuilder<ShootRecord, ShootRecord, QDistinct> distinctByHitTarget() {
    return addDistinctByInternal('hitTarget');
  }

  QueryBuilder<ShootRecord, ShootRecord, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ShootRecord, ShootRecord, QDistinct> distinctByMissed() {
    return addDistinctByInternal('missed');
  }
}

extension ShootRecordQueryProperty
    on QueryBuilder<ShootRecord, ShootRecord, QQueryProperty> {
  QueryBuilder<ShootRecord, DateTime, QQueryOperations> dateTimeProperty() {
    return addPropertyNameInternal('dateTime');
  }

  QueryBuilder<ShootRecord, double, QQueryOperations> hitPositionXProperty() {
    return addPropertyNameInternal('hitPositionX');
  }

  QueryBuilder<ShootRecord, double, QQueryOperations> hitPositionYProperty() {
    return addPropertyNameInternal('hitPositionY');
  }

  QueryBuilder<ShootRecord, bool, QQueryOperations> hitTargetProperty() {
    return addPropertyNameInternal('hitTarget');
  }

  QueryBuilder<ShootRecord, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ShootRecord, bool, QQueryOperations> missedProperty() {
    return addPropertyNameInternal('missed');
  }
}
