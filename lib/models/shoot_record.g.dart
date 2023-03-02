// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shoot_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetShootRecordCollection on Isar {
  IsarCollection<ShootRecord> get shootRecords => this.collection();
}

const ShootRecordSchema = CollectionSchema(
  name: r'ShootRecord',
  id: 8447093813824157044,
  properties: {
    r'dateTime': PropertySchema(
      id: 0,
      name: r'dateTime',
      type: IsarType.dateTime,
    ),
    r'hitPositionX': PropertySchema(
      id: 1,
      name: r'hitPositionX',
      type: IsarType.double,
    ),
    r'hitPositionY': PropertySchema(
      id: 2,
      name: r'hitPositionY',
      type: IsarType.double,
    ),
    r'hitTarget': PropertySchema(
      id: 3,
      name: r'hitTarget',
      type: IsarType.bool,
    ),
    r'missed': PropertySchema(
      id: 4,
      name: r'missed',
      type: IsarType.bool,
    )
  },
  estimateSize: _shootRecordEstimateSize,
  serialize: _shootRecordSerialize,
  deserialize: _shootRecordDeserialize,
  deserializeProp: _shootRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'round': LinkSchema(
      id: -1208914991570836461,
      name: r'round',
      target: r'ShootRound',
      single: true,
      linkName: r'relatedRecord',
    )
  },
  embeddedSchemas: {},
  getId: _shootRecordGetId,
  getLinks: _shootRecordGetLinks,
  attach: _shootRecordAttach,
  version: '3.0.5',
);

int _shootRecordEstimateSize(
  ShootRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _shootRecordSerialize(
  ShootRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateTime);
  writer.writeDouble(offsets[1], object.hitPositionX);
  writer.writeDouble(offsets[2], object.hitPositionY);
  writer.writeBool(offsets[3], object.hitTarget);
  writer.writeBool(offsets[4], object.missed);
}

ShootRecord _shootRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ShootRecord();
  object.dateTime = reader.readDateTime(offsets[0]);
  object.hitPositionX = reader.readDouble(offsets[1]);
  object.hitPositionY = reader.readDouble(offsets[2]);
  object.hitTarget = reader.readBool(offsets[3]);
  object.id = id;
  object.missed = reader.readBool(offsets[4]);
  return object;
}

P _shootRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
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
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _shootRecordGetId(ShootRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _shootRecordGetLinks(ShootRecord object) {
  return [object.round];
}

void _shootRecordAttach(
    IsarCollection<dynamic> col, Id id, ShootRecord object) {
  object.id = id;
  object.round.attach(col, col.isar.collection<ShootRound>(), r'round', id);
}

extension ShootRecordQueryWhereSort
    on QueryBuilder<ShootRecord, ShootRecord, QWhere> {
  QueryBuilder<ShootRecord, ShootRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ShootRecordQueryWhere
    on QueryBuilder<ShootRecord, ShootRecord, QWhereClause> {
  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterWhereClause> idBetween(
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

extension ShootRecordQueryFilter
    on QueryBuilder<ShootRecord, ShootRecord, QFilterCondition> {
  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> dateTimeEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
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

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      dateTimeLessThan(
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

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> dateTimeBetween(
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

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionXEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hitPositionX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionXGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hitPositionX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionXLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hitPositionX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionXBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hitPositionX',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionYEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hitPositionY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionYGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hitPositionY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionYLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hitPositionY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitPositionYBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hitPositionY',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition>
      hitTargetEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hitTarget',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> missedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'missed',
        value: value,
      ));
    });
  }
}

extension ShootRecordQueryObject
    on QueryBuilder<ShootRecord, ShootRecord, QFilterCondition> {}

extension ShootRecordQueryLinks
    on QueryBuilder<ShootRecord, ShootRecord, QFilterCondition> {
  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> round(
      FilterQuery<ShootRound> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'round');
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterFilterCondition> roundIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'round', 0, true, 0, true);
    });
  }
}

extension ShootRecordQuerySortBy
    on QueryBuilder<ShootRecord, ShootRecord, QSortBy> {
  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByHitPositionX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitPositionX', Sort.asc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy>
      sortByHitPositionXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitPositionX', Sort.desc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByHitPositionY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitPositionY', Sort.asc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy>
      sortByHitPositionYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitPositionY', Sort.desc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByHitTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitTarget', Sort.asc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByHitTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitTarget', Sort.desc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByMissed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'missed', Sort.asc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> sortByMissedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'missed', Sort.desc);
    });
  }
}

extension ShootRecordQuerySortThenBy
    on QueryBuilder<ShootRecord, ShootRecord, QSortThenBy> {
  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByHitPositionX() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitPositionX', Sort.asc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy>
      thenByHitPositionXDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitPositionX', Sort.desc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByHitPositionY() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitPositionY', Sort.asc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy>
      thenByHitPositionYDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitPositionY', Sort.desc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByHitTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitTarget', Sort.asc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByHitTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hitTarget', Sort.desc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByMissed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'missed', Sort.asc);
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QAfterSortBy> thenByMissedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'missed', Sort.desc);
    });
  }
}

extension ShootRecordQueryWhereDistinct
    on QueryBuilder<ShootRecord, ShootRecord, QDistinct> {
  QueryBuilder<ShootRecord, ShootRecord, QDistinct> distinctByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime');
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QDistinct> distinctByHitPositionX() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hitPositionX');
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QDistinct> distinctByHitPositionY() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hitPositionY');
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QDistinct> distinctByHitTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hitTarget');
    });
  }

  QueryBuilder<ShootRecord, ShootRecord, QDistinct> distinctByMissed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'missed');
    });
  }
}

extension ShootRecordQueryProperty
    on QueryBuilder<ShootRecord, ShootRecord, QQueryProperty> {
  QueryBuilder<ShootRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ShootRecord, DateTime, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<ShootRecord, double, QQueryOperations> hitPositionXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hitPositionX');
    });
  }

  QueryBuilder<ShootRecord, double, QQueryOperations> hitPositionYProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hitPositionY');
    });
  }

  QueryBuilder<ShootRecord, bool, QQueryOperations> hitTargetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hitTarget');
    });
  }

  QueryBuilder<ShootRecord, bool, QQueryOperations> missedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'missed');
    });
  }
}
