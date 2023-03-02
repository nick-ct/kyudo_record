// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoot_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetShootHistoryCollection on Isar {
  IsarCollection<ShootHistory> get shootHistorys => this.collection();
}

const ShootHistorySchema = CollectionSchema(
  name: r'ShootHistory',
  id: 4745019105067358334,
  properties: {
    r'date': PropertySchema(
      id: 0,
      name: r'date',
      type: IsarType.string,
    ),
    r'totalHitTarget': PropertySchema(
      id: 1,
      name: r'totalHitTarget',
      type: IsarType.long,
    ),
    r'totalRound': PropertySchema(
      id: 2,
      name: r'totalRound',
      type: IsarType.long,
    ),
    r'totalShoot': PropertySchema(
      id: 3,
      name: r'totalShoot',
      type: IsarType.long,
    )
  },
  estimateSize: _shootHistoryEstimateSize,
  serialize: _shootHistorySerialize,
  deserialize: _shootHistoryDeserialize,
  deserializeProp: _shootHistoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'relatedRound': LinkSchema(
      id: -1948768005780295849,
      name: r'relatedRound',
      target: r'ShootRound',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _shootHistoryGetId,
  getLinks: _shootHistoryGetLinks,
  attach: _shootHistoryAttach,
  version: '3.0.5',
);

int _shootHistoryEstimateSize(
  ShootHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.date.length * 3;
  return bytesCount;
}

void _shootHistorySerialize(
  ShootHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.date);
  writer.writeLong(offsets[1], object.totalHitTarget);
  writer.writeLong(offsets[2], object.totalRound);
  writer.writeLong(offsets[3], object.totalShoot);
}

ShootHistory _shootHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ShootHistory();
  object.date = reader.readString(offsets[0]);
  object.id = id;
  object.totalHitTarget = reader.readLong(offsets[1]);
  object.totalRound = reader.readLong(offsets[2]);
  object.totalShoot = reader.readLong(offsets[3]);
  return object;
}

P _shootHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
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

Id _shootHistoryGetId(ShootHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _shootHistoryGetLinks(ShootHistory object) {
  return [object.relatedRound];
}

void _shootHistoryAttach(
    IsarCollection<dynamic> col, Id id, ShootHistory object) {
  object.id = id;
  object.relatedRound
      .attach(col, col.isar.collection<ShootRound>(), r'relatedRound', id);
}

extension ShootHistoryQueryWhereSort
    on QueryBuilder<ShootHistory, ShootHistory, QWhere> {
  QueryBuilder<ShootHistory, ShootHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ShootHistoryQueryWhere
    on QueryBuilder<ShootHistory, ShootHistory, QWhereClause> {
  QueryBuilder<ShootHistory, ShootHistory, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<ShootHistory, ShootHistory, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterWhereClause> idBetween(
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

extension ShootHistoryQueryFilter
    on QueryBuilder<ShootHistory, ShootHistory, QFilterCondition> {
  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> dateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      dateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> dateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> dateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      dateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> dateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> dateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'date',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> dateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'date',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      dateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      dateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'date',
        value: '',
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalHitTargetEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalHitTarget',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalHitTargetGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalHitTarget',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalHitTargetLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalHitTarget',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalHitTargetBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalHitTarget',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalRoundEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalRound',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalRoundGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalRound',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalRoundLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalRound',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalRoundBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalRound',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalShootEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalShoot',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalShootGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalShoot',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalShootLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalShoot',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      totalShootBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalShoot',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ShootHistoryQueryObject
    on QueryBuilder<ShootHistory, ShootHistory, QFilterCondition> {}

extension ShootHistoryQueryLinks
    on QueryBuilder<ShootHistory, ShootHistory, QFilterCondition> {
  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition> relatedRound(
      FilterQuery<ShootRound> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'relatedRound');
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      relatedRoundLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'relatedRound', length, true, length, true);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      relatedRoundIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'relatedRound', 0, true, 0, true);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      relatedRoundIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'relatedRound', 0, false, 999999, true);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      relatedRoundLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'relatedRound', 0, true, length, include);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      relatedRoundLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'relatedRound', length, include, 999999, true);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterFilterCondition>
      relatedRoundLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'relatedRound', lower, includeLower, upper, includeUpper);
    });
  }
}

extension ShootHistoryQuerySortBy
    on QueryBuilder<ShootHistory, ShootHistory, QSortBy> {
  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      sortByTotalHitTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalHitTarget', Sort.asc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      sortByTotalHitTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalHitTarget', Sort.desc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> sortByTotalRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRound', Sort.asc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      sortByTotalRoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRound', Sort.desc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> sortByTotalShoot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalShoot', Sort.asc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      sortByTotalShootDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalShoot', Sort.desc);
    });
  }
}

extension ShootHistoryQuerySortThenBy
    on QueryBuilder<ShootHistory, ShootHistory, QSortThenBy> {
  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      thenByTotalHitTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalHitTarget', Sort.asc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      thenByTotalHitTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalHitTarget', Sort.desc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> thenByTotalRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRound', Sort.asc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      thenByTotalRoundDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalRound', Sort.desc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy> thenByTotalShoot() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalShoot', Sort.asc);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QAfterSortBy>
      thenByTotalShootDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalShoot', Sort.desc);
    });
  }
}

extension ShootHistoryQueryWhereDistinct
    on QueryBuilder<ShootHistory, ShootHistory, QDistinct> {
  QueryBuilder<ShootHistory, ShootHistory, QDistinct> distinctByDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QDistinct>
      distinctByTotalHitTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalHitTarget');
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QDistinct> distinctByTotalRound() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalRound');
    });
  }

  QueryBuilder<ShootHistory, ShootHistory, QDistinct> distinctByTotalShoot() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalShoot');
    });
  }
}

extension ShootHistoryQueryProperty
    on QueryBuilder<ShootHistory, ShootHistory, QQueryProperty> {
  QueryBuilder<ShootHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ShootHistory, String, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<ShootHistory, int, QQueryOperations> totalHitTargetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalHitTarget');
    });
  }

  QueryBuilder<ShootHistory, int, QQueryOperations> totalRoundProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalRound');
    });
  }

  QueryBuilder<ShootHistory, int, QQueryOperations> totalShootProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalShoot');
    });
  }
}
