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
      '{"name":"ShootRound","idName":"id","properties":[{"name":"date","type":"String"},{"name":"round","type":"Long"},{"name":"shootCount","type":"Long"}],"indexes":[{"name":"date","unique":false,"properties":[{"name":"date","type":"Hash","caseSensitive":true}]}],"links":[{"name":"relatedRecord","target":"ShootRecord"}]}',
  idName: 'id',
  propertyIds: {'date': 0, 'round': 1, 'shootCount': 2},
  listProperties: {},
  indexIds: {'date': 0},
  indexValueTypes: {
    'date': [
      IndexValueType.stringHash,
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
  final value0 = object.date;
  final _date = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_date.length) as int;
  final value1 = object.round;
  final _round = value1;
  final value2 = object.shootCount;
  final _shootCount = value2;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _date);
  writer.writeLong(offsets[1], _round);
  writer.writeLong(offsets[2], _shootCount);
}

ShootRound _shootRoundDeserializeNative(IsarCollection<ShootRound> collection,
    int id, IsarBinaryReader reader, List<int> offsets) {
  final object = ShootRound();
  object.id = id;
  object.round = reader.readLong(offsets[1]);
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
      return (reader.readString(offset)) as P;
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
  IsarNative.jsObjectSet(jsObj, 'date', object.date);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'round', object.round);
  IsarNative.jsObjectSet(jsObj, 'shootCount', object.shootCount);
  return jsObj;
}

ShootRound _shootRoundDeserializeWeb(
    IsarCollection<ShootRound> collection, dynamic jsObj) {
  final object = ShootRound();
  object.id = IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity;
  object.round =
      IsarNative.jsObjectGet(jsObj, 'round') ?? double.negativeInfinity;
  object.shootCount =
      IsarNative.jsObjectGet(jsObj, 'shootCount') ?? double.negativeInfinity;
  _shootRoundAttachLinks(collection,
      IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity, object);
  return object;
}

P _shootRoundDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'date':
      return (IsarNative.jsObjectGet(jsObj, 'date') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'round':
      return (IsarNative.jsObjectGet(jsObj, 'round') ?? double.negativeInfinity)
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

  QueryBuilder<ShootRound, ShootRound, QAfterWhere> anyDate() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'date'));
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

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> dateEqualTo(
      String date) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'date',
      value: [date],
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> dateNotEqualTo(
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

extension ShootRoundQueryFilter
    on QueryBuilder<ShootRound, ShootRound, QFilterCondition> {
  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateEqualTo(
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateGreaterThan(
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateLessThan(
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateBetween(
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateStartsWith(
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateEndsWith(
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'date',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'date',
      value: pattern,
      caseSensitive: caseSensitive,
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

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> roundEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'round',
      value: value,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> roundGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'round',
      value: value,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> roundLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'round',
      value: value,
    ));
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> roundBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'round',
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
  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByDate() {
    return addSortByInternal('date', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByDateDesc() {
    return addSortByInternal('date', Sort.desc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByRound() {
    return addSortByInternal('round', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByRoundDesc() {
    return addSortByInternal('round', Sort.desc);
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
  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByDate() {
    return addSortByInternal('date', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByDateDesc() {
    return addSortByInternal('date', Sort.desc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByRound() {
    return addSortByInternal('round', Sort.asc);
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByRoundDesc() {
    return addSortByInternal('round', Sort.desc);
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
  QueryBuilder<ShootRound, ShootRound, QDistinct> distinctByDate(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('date', caseSensitive: caseSensitive);
  }

  QueryBuilder<ShootRound, ShootRound, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<ShootRound, ShootRound, QDistinct> distinctByRound() {
    return addDistinctByInternal('round');
  }

  QueryBuilder<ShootRound, ShootRound, QDistinct> distinctByShootCount() {
    return addDistinctByInternal('shootCount');
  }
}

extension ShootRoundQueryProperty
    on QueryBuilder<ShootRound, ShootRound, QQueryProperty> {
  QueryBuilder<ShootRound, String, QQueryOperations> dateProperty() {
    return addPropertyNameInternal('date');
  }

  QueryBuilder<ShootRound, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<ShootRound, int, QQueryOperations> roundProperty() {
    return addPropertyNameInternal('round');
  }

  QueryBuilder<ShootRound, int, QQueryOperations> shootCountProperty() {
    return addPropertyNameInternal('shootCount');
  }
}
