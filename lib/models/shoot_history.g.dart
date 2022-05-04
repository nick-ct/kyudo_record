// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoot_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetShootHistoryCollection on Isar {
  IsarCollection<ShootHistory> get shootHistorys => getCollection();
}

const ShootHistorySchema = CollectionSchema(
  name: 'ShootHistory',
  schema:
      '{"name":"ShootHistory","idName":"id","properties":[{"name":"date","type":"String"},{"name":"totalHitTarget","type":"Long"},{"name":"totalRound","type":"Long"},{"name":"totalShoot","type":"Long"}],"indexes":[{"name":"date","unique":false,"properties":[{"name":"date","type":"Hash","caseSensitive":true}]}],"links":[{"name":"relatedRound","target":"ShootRound"}]}',
  idName: 'id',
  propertyIds: {
    'date': 0,
    'totalHitTarget': 1,
    'totalRound': 2,
    'totalShoot': 3
  },
  listProperties: {},
  indexIds: {'date': 0},
  indexValueTypes: {
    'date': [
      IndexValueType.stringHash,
    ]
  },
  linkIds: {'relatedRound': 0},
  backlinkLinkNames: {},
  getId: _shootHistoryGetId,
  setId: _shootHistorySetId,
  getLinks: _shootHistoryGetLinks,
  attachLinks: _shootHistoryAttachLinks,
  serializeNative: _shootHistorySerializeNative,
  deserializeNative: _shootHistoryDeserializeNative,
  deserializePropNative: _shootHistoryDeserializePropNative,
  serializeWeb: _shootHistorySerializeWeb,
  deserializeWeb: _shootHistoryDeserializeWeb,
  deserializePropWeb: _shootHistoryDeserializePropWeb,
  version: 3,
);

int? _shootHistoryGetId(ShootHistory object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _shootHistorySetId(ShootHistory object, int id) {
  object.id = id;
}

List<IsarLinkBase> _shootHistoryGetLinks(ShootHistory object) {
  return [object.relatedRound];
}

void _shootHistorySerializeNative(
    IsarCollection<ShootHistory> collection,
    IsarRawObject rawObj,
    ShootHistory object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.date;
  final _date = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_date.length) as int;
  final value1 = object.totalHitTarget;
  final _totalHitTarget = value1;
  final value2 = object.totalRound;
  final _totalRound = value2;
  final value3 = object.totalShoot;
  final _totalShoot = value3;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _date);
  writer.writeLong(offsets[1], _totalHitTarget);
  writer.writeLong(offsets[2], _totalRound);
  writer.writeLong(offsets[3], _totalShoot);
}

ShootHistory _shootHistoryDeserializeNative(
    IsarCollection<ShootHistory> collection,
    int id,
    IsarBinaryReader reader,
    List<int> offsets) {
  final object = ShootHistory();
  object.date = reader.readString(offsets[0]);
  object.id = id;
  object.totalHitTarget = reader.readLong(offsets[1]);
  object.totalRound = reader.readLong(offsets[2]);
  object.totalShoot = reader.readLong(offsets[3]);
  _shootHistoryAttachLinks(collection, id, object);
  return object;
}

P _shootHistoryDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _shootHistorySerializeWeb(
    IsarCollection<ShootHistory> collection, ShootHistory object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'date', object.date);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'totalHitTarget', object.totalHitTarget);
  IsarNative.jsObjectSet(jsObj, 'totalRound', object.totalRound);
  IsarNative.jsObjectSet(jsObj, 'totalShoot', object.totalShoot);
  return jsObj;
}

ShootHistory _shootHistoryDeserializeWeb(
    IsarCollection<ShootHistory> collection, dynamic jsObj) {
  final object = ShootHistory();
  object.date = IsarNative.jsObjectGet(jsObj, 'date') ?? '';
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.totalHitTarget = IsarNative.jsObjectGet(jsObj, 'totalHitTarget') ??
      double.negativeInfinity;
  object.totalRound =
      IsarNative.jsObjectGet(jsObj, 'totalRound') ?? double.negativeInfinity;
  object.totalShoot =
      IsarNative.jsObjectGet(jsObj, 'totalShoot') ?? double.negativeInfinity;
  _shootHistoryAttachLinks(collection,
      IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity, object);
  return object;
}

P _shootHistoryDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'date':
      return (IsarNative.jsObjectGet(jsObj, 'date') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'totalHitTarget':
      return (IsarNative.jsObjectGet(jsObj, 'totalHitTarget') ??
          double.negativeInfinity) as P;
    case 'totalRound':
      return (IsarNative.jsObjectGet(jsObj, 'totalRound') ??
          double.negativeInfinity) as P;
    case 'totalShoot':
      return (IsarNative.jsObjectGet(jsObj, 'totalShoot') ??
          double.negativeInfinity) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _shootHistoryAttachLinks(IsarCollection col, int id, ShootHistory object) {
  object.relatedRound.attach(col, col.isar.shootRounds, 'relatedRound', id);
}

extension ShootHistoryQueryWhereSort
    on QueryBuilder<ShootHistory, ShootHistory, QWhere> {
  QueryBuilder<ShootHistory, ShootHistory, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterWhere> anyDate() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'date'));
  }
}

extension ShootHistoryQueryWhere
    on QueryBuilder<ShootHistory, ShootHistory, QWhereClause> {
  QueryBuilder<ShootHistory, ShootHistory, QAfterWhereClause> idEqualTo(
      int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ShootHistory, ShootHistory, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterWhereClause> idBetween(
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

  QueryBuilder<ShootHistory, ShootHistory, QAfterWhereClause> dateEqualTo(
      String date) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'date',
      value: [date],
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterWhereClause> dateNotEqualTo(
      String date) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'date',
        upper: [date],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'date',
        lower: [date],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'date',
        lower: [date],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'date',
        upper: [date],
        includeUpper: false,
      ));
    }
  }
}

extension ShootHistoryQueryFilter
    on QueryBuilder<ShootHistory, ShootHistory, QFilterCondition> {
  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> dateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'date',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      dateGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'date',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> dateLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'date',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> dateBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'date',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      dateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'date',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> dateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'date',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> dateContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'date',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> dateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'date',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalHitTargetEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'totalHitTarget',
      value: value,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalHitTargetGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'totalHitTarget',
      value: value,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalHitTargetLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'totalHitTarget',
      value: value,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalHitTargetBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'totalHitTarget',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalRoundEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'totalRound',
      value: value,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalRoundGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'totalRound',
      value: value,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalRoundLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'totalRound',
      value: value,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalRoundBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'totalRound',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalShootEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'totalShoot',
      value: value,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalShootGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'totalShoot',
      value: value,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalShootLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'totalShoot',
      value: value,
    ));
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalShootBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'totalShoot',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension ShootHistoryQueryLinks
    on QueryBuilder<ShootHistory, ShootHistory, QFilterCondition> {
  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> relatedRound(
      FilterQuery<ShootRound> q) {
    return linkInternal(
      isar.shootRounds,
      q,
      'relatedRound',
    );
  }
}

extension ShootHistoryQueryWhereSortBy
    on QueryBuilder<ShootHistory, ShootHistory, QSortBy> {
  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> sortByDate() {
    return addSortByInternal('date', Sort.asc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> sortByDateDesc() {
    return addSortByInternal('date', Sort.desc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      sortByTotalHitTarget() {
    return addSortByInternal('totalHitTarget', Sort.asc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      sortByTotalHitTargetDesc() {
    return addSortByInternal('totalHitTarget', Sort.desc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> sortByTotalRound() {
    return addSortByInternal('totalRound', Sort.asc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      sortByTotalRoundDesc() {
    return addSortByInternal('totalRound', Sort.desc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> sortByTotalShoot() {
    return addSortByInternal('totalShoot', Sort.asc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      sortByTotalShootDesc() {
    return addSortByInternal('totalShoot', Sort.desc);
  }
}

extension ShootHistoryQueryWhereSortThenBy
    on QueryBuilder<ShootHistory, ShootHistory, QSortThenBy> {
  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> thenByDate() {
    return addSortByInternal('date', Sort.asc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> thenByDateDesc() {
    return addSortByInternal('date', Sort.desc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      thenByTotalHitTarget() {
    return addSortByInternal('totalHitTarget', Sort.asc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      thenByTotalHitTargetDesc() {
    return addSortByInternal('totalHitTarget', Sort.desc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> thenByTotalRound() {
    return addSortByInternal('totalRound', Sort.asc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      thenByTotalRoundDesc() {
    return addSortByInternal('totalRound', Sort.desc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> thenByTotalShoot() {
    return addSortByInternal('totalShoot', Sort.asc);
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      thenByTotalShootDesc() {
    return addSortByInternal('totalShoot', Sort.desc);
  }
}

extension ShootHistoryQueryWhereDistinct
    on QueryBuilder<ShootHistory, ShootHistory, QDistinct> {
  QueryBuilder<ShootHistory, ShootHistory, QDistinct> distinctByDate(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('date', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShootHistory, ShootHistory, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ShootHistory, ShootHistory, QDistinct>
      distinctByTotalHitTarget() {
    return addDistinctByInternal('totalHitTarget');
  }

  QueryBuilder<ShootHistory, ShootHistory, QDistinct> distinctByTotalRound() {
    return addDistinctByInternal('totalRound');
  }

  QueryBuilder<ShootHistory, ShootHistory, QDistinct> distinctByTotalShoot() {
    return addDistinctByInternal('totalShoot');
  }
}

extension ShootHistoryQueryProperty
    on QueryBuilder<ShootHistory, ShootHistory, QQueryProperty> {
  QueryBuilder<ShootHistory, String, QQueryOperations> dateProperty() {
    return addPropertyNameInternal('date');
  }

  QueryBuilder<ShootHistory, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ShootHistory, int, QQueryOperations> totalHitTargetProperty() {
    return addPropertyNameInternal('totalHitTarget');
  }

  QueryBuilder<ShootHistory, int, QQueryOperations> totalRoundProperty() {
    return addPropertyNameInternal('totalRound');
  }

  QueryBuilder<ShootHistory, int, QQueryOperations> totalShootProperty() {
    return addPropertyNameInternal('totalShoot');
  }
}
