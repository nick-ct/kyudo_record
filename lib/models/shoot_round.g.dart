// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoot_round.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetShootRoundCollection on Isar {
  IsarCollection<ShootRound> get shootRounds => this.collection();
}

const ShootRoundSchema = CollectionSchema(
  name: r'ShootRound',
  id: 2809570828714226550,
  properties: {
    r'dateTime': PropertySchema(
      id: 0,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'hitCount': PropertySchema(
      id: 1,
      name: r'hitCount',
      type: IsarType.long,
    ),
    r'matoSize': PropertySchema(
      id: 2,
      name: r'matoSize',
      type: IsarType.long,
    ),
    r'shootCount': PropertySchema(
      id: 3,
      name: r'shootCount',
      type: IsarType.long,
    )
  },
  estimateSize: _shootRoundEstimateSize,
  serialize: _shootRoundSerialize,
  deserialize: _shootRoundDeserialize,
  deserializeProp: _shootRoundDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'relatedRecord': LinkSchema(
      id: -3033380282742986763,
      name: r'relatedRecord',
      target: r'ShootRecord',
      single: false,
    ),
    r'history': LinkSchema(
      id: -7225483399530619350,
      name: r'history',
      target: r'ShootHistory',
      single: true,
      linkName: r'relatedRound',
    )
  },
  embeddedSchemas: {},
  getId: _shootRoundGetId,
  getLinks: _shootRoundGetLinks,
  attach: _shootRoundAttach,
  version: '3.0.5',
);

int _shootRoundEstimateSize(
  ShootRound object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _shootRoundSerialize(
  ShootRound object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateTime);
  writer.writeLong(offsets[1], object.hitCount);
  writer.writeLong(offsets[2], object.matoSize);
  writer.writeLong(offsets[3], object.shootCount);
}

ShootRound _shootRoundDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ShootRound();
  object.dateTime = reader.readDateTime(offsets[0]);
  object.hitCount = reader.readLong(offsets[1]);
  object.id = id;
  object.matoSize = reader.readLong(offsets[2]);
  object.shootCount = reader.readLong(offsets[3]);
  return object;
}

P _shootRoundDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _shootRoundGetId(ShootRound object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _shootRoundGetLinks(ShootRound object) {
  return [object.relatedRecord, object.history];
}

void _shootRoundAttach(IsarCollection<dynamic> col, Id id, ShootRound object) {
  object.id = id;
  object.relatedRecord
      .attach(col, col.isar.collection<ShootRecord>(), r'relatedRecord', id);
  object.history
      .attach(col, col.isar.collection<ShootHistory>(), r'history', id);
}

extension ShootRoundQueryWhereSort
    on QueryBuilder<ShootRound, ShootRound, QWhere> {
  QueryBuilder<ShootRound, ShootRound, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ShootRoundQueryWhere
    on QueryBuilder<ShootRound, ShootRound, QWhereClause> {
  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ShootRoundQueryFilter
    on QueryBuilder<ShootRound, ShootRound, QFilterCondition> {
  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      dateTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> dateTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> hitCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hitCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      hitCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hitCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> hitCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hitCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> hitCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hitCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> matoSizeEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matoSize',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      matoSizeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matoSize',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> matoSizeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matoSize',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> matoSizeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matoSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> shootCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shootCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      shootCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shootCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      shootCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shootCount',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> shootCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shootCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ShootRoundQueryObject
    on QueryBuilder<ShootRound, ShootRound, QFilterCondition> {}

extension ShootRoundQueryLinks
    on QueryBuilder<ShootRound, ShootRound, QFilterCondition> {
  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> relatedRecord(
      FilterQuery<ShootRecord> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'relatedRecord');
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      relatedRecordLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'relatedRecord', length, true, length, true);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      relatedRecordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'relatedRecord', 0, true, 0, true);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      relatedRecordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'relatedRecord', 0, false, 999999, true);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      relatedRecordLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'relatedRecord', 0, true, length, include);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      relatedRecordLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'relatedRecord', length, include, 999999, true);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition>
      relatedRecordLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'relatedRecord', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> history(
      FilterQuery<ShootHistory> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'history');
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterFilterCondition> historyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'history', 0, true, 0, true);
    });
  }
}

extension ShootRoundQuerySortBy
    on QueryBuilder<ShootRound, ShootRound, QSortBy> {
  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByHitCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitCount', Sort.asc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByHitCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitCount', Sort.desc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByMatoSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matoSize', Sort.asc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByMatoSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matoSize', Sort.desc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByShootCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shootCount', Sort.asc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> sortByShootCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shootCount', Sort.desc);
    });
  }
}

extension ShootRoundQuerySortThenBy
    on QueryBuilder<ShootRound, ShootRound, QSortThenBy> {
  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByHitCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitCount', Sort.asc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByHitCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitCount', Sort.desc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByMatoSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matoSize', Sort.asc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByMatoSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matoSize', Sort.desc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByShootCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shootCount', Sort.asc);
    });
  }

  QueryBuilder<ShootRound, ShootRound, QAfterSortBy> thenByShootCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shootCount', Sort.desc);
    });
  }
}

extension ShootRoundQueryWhereDistinct
    on QueryBuilder<ShootRound, ShootRound, QDistinct> {
  QueryBuilder<ShootRound, ShootRound, QDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<ShootRound, ShootRound, QDistinct> distinctByHitCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hitCount');
    });
  }

  QueryBuilder<ShootRound, ShootRound, QDistinct> distinctByMatoSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matoSize');
    });
  }

  QueryBuilder<ShootRound, ShootRound, QDistinct> distinctByShootCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shootCount');
    });
  }
}

extension ShootRoundQueryProperty
    on QueryBuilder<ShootRound, ShootRound, QQueryProperty> {
  QueryBuilder<ShootRound, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ShootRound, DateTime, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<ShootRound, int, QQueryOperations> hitCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hitCount');
    });
  }

  QueryBuilder<ShootRound, int, QQueryOperations> matoSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matoSize');
    });
  }

  QueryBuilder<ShootRound, int, QQueryOperations> shootCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shootCount');
    });
  }
}
