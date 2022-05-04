// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoot_round.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetShootRoundCollection on Isar {
  IsarCollection<ShootRound> get shootRounds => getCollection();
}

const ShootRoundSchema = CollectionSchema(
  name: 'ShootRound',
  schema:
      '{"name":"ShootRound","idName":"id","properties":[{"name":"dateTime","type":"Long"},{"name":"hitCount","type":"Long"},{"name":"shootCount","type":"Long"}],"indexes":[{"name":"dateTime","unique":false,"properties":[{"name":"dateTime","type":"Value","caseSensitive":false}]}],"links":[{"name":"relatedRecord","target":"ShootRecord"}]}',
  idName: 'id',
  propertyIds: {'dateTime': 0, 'hitCount': 1, 'shootCount': 2},
  listProperties: {},
  indexIds: {'dateTime': 0},
  indexValueTypes: {
    'dateTime': [
      IndexValueType.long,
    ]
  },
  linkIds: {'relatedRecord': 0},
  backlinkLinkNames: {},
  getId: _shootRoundGetId,
  setId: _shootRoundSetId,
  getLinks: _shootRoundGetLinks,
  attachLinks: _shootRoundAttachLinks,
  serializeNative: _shootRoundSerializeNative,
  deserializeNative: _shootRoundDeserializeNative,
  deserializePropNative: _shootRoundDeserializePropNative,
  serializeWeb: _shootRoundSerializeWeb,
  deserializeWeb: _shootRoundDeserializeWeb,
  deserializePropWeb: _shootRoundDeserializePropWeb,
  version: 3,
);

int? _shootRoundGetId(ShootRound object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _shootRoundSetId(ShootRound object, int id) {
  object.id = id;
}

List<IsarLinkBase> _shootRoundGetLinks(ShootRound object) {
  return [object.relatedRecord];
}

void _shootRoundSerializeNative(
    IsarCollection<ShootRound> collection,
    IsarRawObject rawObj,
    ShootRound object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.dateTime;
  final _dateTime = value0;
  final value1 = object.hitCount;
  final _hitCount = value1;
  final value2 = object.shootCount;
  final _shootCount = value2;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeDateTime(offsets[0], _dateTime);
  writer.writeLong(offsets[1], _hitCount);
  writer.writeLong(offsets[2], _shootCount);
}

ShootRound _shootRoundDeserializeNative(IsarCollection<ShootRound> collection,
    int id, IsarBinaryReader reader, List<int> offsets) {
  final object = ShootRound();
  object.dateTime = reader.readDateTime(offsets[0]);
  object.hitCount = reader.readLong(offsets[1]);
  object.id = id;
  object.shootCount = reader.readLong(offsets[2]);
  _shootRoundAttachLinks(collection, id, object);
  return object;
}

P _shootRoundDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _shootRoundSerializeWeb(
    IsarCollection<ShootRound> collection, ShootRound object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(
      jsObj, 'dateTime', object.dateTime.toUtc().millisecondsSinceEpoch);
  IsarNative.jsObjectSet(jsObj, 'hitCount', object.hitCount);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'shootCount', object.shootCount);
  return jsObj;
}

ShootRound _shootRoundDeserializeWeb(
    IsarCollection<ShootRound> collection, dynamic jsObj) {
  final object = ShootRound();
  object.dateTime = IsarNative.jsObjectGet(jsObj, 'dateTime') != null
      ? DateTime.fromMillisecondsSinceEpoch(
              IsarNative.jsObjectGet(jsObj, 'dateTime'),
              isUtc: true)
          .toLocal()
      : DateTime.fromMillisecondsSinceEpoch(0);
  object.hitCount =
      IsarNative.jsObjectGet(jsObj, 'hitCount') ?? double.negativeInfinity;
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.shootCount =
      IsarNative.jsObjectGet(jsObj, 'shootCount') ?? double.negativeInfinity;
  _shootRoundAttachLinks(collection,
      IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity, object);
  return object;
}

P _shootRoundDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'dateTime':
      return (IsarNative.jsObjectGet(jsObj, 'dateTime') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'dateTime'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    case 'hitCount':
      return (IsarNative.jsObjectGet(jsObj, 'hitCount') ??
          double.negativeInfinity) as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'shootCount':
      return (IsarNative.jsObjectGet(jsObj, 'shootCount') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _shootRoundAttachLinks(IsarCollection col, int id, ShootRound object) {
  object.relatedRecord.attach(col, col.isar.shootRecords, 'relatedRecord', id);
}

extension ShootRoundQueryWhereSort
    on QueryBuilder<ShootRound, ShootRound, QWhere> {
  QueryBuilder<ShootRound, ShootRound, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<ShootRound, ShootRound, QAfterWhere> anyDateTime() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'dateTime'));
  }
}

extension ShootRoundQueryWhere
    on QueryBuilder<ShootRound, ShootRound, QWhereClause> {
  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> idNotEqualTo(int id) {
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

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> idBetween(
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

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> dateTimeEqualTo(
      DateTime dateTime) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'dateTime',
      value: [dateTime],
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> dateTimeNotEqualTo(
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

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> dateTimeGreaterThan(
    DateTime dateTime, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'dateTime',
      lower: [dateTime],
      includeLower: include,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> dateTimeLessThan(
    DateTime dateTime, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'dateTime',
      upper: [dateTime],
      includeUpper: include,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> dateTimeBetween(
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

extension ShootRoundQueryFilter
    on QueryBuilder<ShootRound, ShootRound, QFilterCondition> {
  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateTimeEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'dateTime',
      value: value,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateTimeLessThan(
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateTimeBetween(
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> hitCountEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'hitCount',
      value: value,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      hitCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'hitCount',
      value: value,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> hitCountLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'hitCount',
      value: value,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> hitCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'hitCount',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> shootCountEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'shootCount',
      value: value,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      shootCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'shootCount',
      value: value,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      shootCountLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'shootCount',
      value: value,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> shootCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'shootCount',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension ShootRoundQueryLinks
    on QueryBuilder<ShootRound, ShootRound, QFilterCondition> {
  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> relatedRecord(
      FilterQuery<ShootRecord> q) {
    return linkInternal(
      isar.shootRecords,
      q,
      'relatedRecord',
    );
  }
}

extension ShootRoundQueryWhereSortBy
    on QueryBuilder<ShootRound, ShootRound, QSortBy> {
  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByDateTime() {
    return addSortByInternal('dateTime', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByDateTimeDesc() {
    return addSortByInternal('dateTime', Sort.desc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByHitCount() {
    return addSortByInternal('hitCount', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByHitCountDesc() {
    return addSortByInternal('hitCount', Sort.desc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByShootCount() {
    return addSortByInternal('shootCount', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByShootCountDesc() {
    return addSortByInternal('shootCount', Sort.desc);
  }
}

extension ShootRoundQueryWhereSortThenBy
    on QueryBuilder<ShootRound, ShootRound, QSortThenBy> {
  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByDateTime() {
    return addSortByInternal('dateTime', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByDateTimeDesc() {
    return addSortByInternal('dateTime', Sort.desc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByHitCount() {
    return addSortByInternal('hitCount', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByHitCountDesc() {
    return addSortByInternal('hitCount', Sort.desc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByShootCount() {
    return addSortByInternal('shootCount', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByShootCountDesc() {
    return addSortByInternal('shootCount', Sort.desc);
  }
}

extension ShootRoundQueryWhereDistinct
    on QueryBuilder<ShootRound, ShootRound, QDistinct> {
  QueryBuilder<ShootRound, ShootRound, QDistinct> distinctByDateTime() {
    return addDistinctByInternal('dateTime');
  }

  QueryBuilder<ShootRound, ShootRound, QDistinct> distinctByHitCount() {
    return addDistinctByInternal('hitCount');
  }

  QueryBuilder<ShootRound, ShootRound, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ShootRound, ShootRound, QDistinct> distinctByShootCount() {
    return addDistinctByInternal('shootCount');
  }
}

extension ShootRoundQueryProperty
    on QueryBuilder<ShootRound, ShootRound, QQueryProperty> {
  QueryBuilder<ShootRound, DateTime, QQueryOperations> dateTimeProperty() {
    return addPropertyNameInternal('dateTime');
  }

  QueryBuilder<ShootRound, int, QQueryOperations> hitCountProperty() {
    return addPropertyNameInternal('hitCount');
  }

  QueryBuilder<ShootRound, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ShootRound, int, QQueryOperations> shootCountProperty() {
    return addPropertyNameInternal('shootCount');
  }
}
