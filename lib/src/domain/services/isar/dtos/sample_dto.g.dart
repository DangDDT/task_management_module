// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarSampleDTOCollection on Isar {
  IsarCollection<IsarSampleDTO> get isarSampleDTOs => this.collection();
}

const IsarSampleDTOSchema = CollectionSchema(
  name: r'IsarSampleDTO',
  id: -3727388629628834859,
  properties: {
    r'title': PropertySchema(
      id: 0,
      name: r'title',
      type: IsarType.long,
    )
  },
  estimateSize: _isarSampleDTOEstimateSize,
  serialize: _isarSampleDTOSerialize,
  deserialize: _isarSampleDTODeserialize,
  deserializeProp: _isarSampleDTODeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _isarSampleDTOGetId,
  getLinks: _isarSampleDTOGetLinks,
  attach: _isarSampleDTOAttach,
  version: '3.1.0+1',
);

int _isarSampleDTOEstimateSize(
  IsarSampleDTO object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _isarSampleDTOSerialize(
  IsarSampleDTO object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.title);
}

IsarSampleDTO _isarSampleDTODeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarSampleDTO(
    id: id,
    title: reader.readLong(offsets[0]),
  );
  return object;
}

P _isarSampleDTODeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarSampleDTOGetId(IsarSampleDTO object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarSampleDTOGetLinks(IsarSampleDTO object) {
  return [];
}

void _isarSampleDTOAttach(
    IsarCollection<dynamic> col, Id id, IsarSampleDTO object) {}

extension IsarSampleDTOQueryWhereSort
    on QueryBuilder<IsarSampleDTO, IsarSampleDTO, QWhere> {
  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarSampleDTOQueryWhere
    on QueryBuilder<IsarSampleDTO, IsarSampleDTO, QWhereClause> {
  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterWhereClause> idBetween(
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

extension IsarSampleDTOQueryFilter
    on QueryBuilder<IsarSampleDTO, IsarSampleDTO, QFilterCondition> {
  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterFilterCondition>
      titleEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterFilterCondition>
      titleGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterFilterCondition>
      titleLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterFilterCondition>
      titleBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarSampleDTOQueryObject
    on QueryBuilder<IsarSampleDTO, IsarSampleDTO, QFilterCondition> {}

extension IsarSampleDTOQueryLinks
    on QueryBuilder<IsarSampleDTO, IsarSampleDTO, QFilterCondition> {}

extension IsarSampleDTOQuerySortBy
    on QueryBuilder<IsarSampleDTO, IsarSampleDTO, QSortBy> {
  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension IsarSampleDTOQuerySortThenBy
    on QueryBuilder<IsarSampleDTO, IsarSampleDTO, QSortThenBy> {
  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension IsarSampleDTOQueryWhereDistinct
    on QueryBuilder<IsarSampleDTO, IsarSampleDTO, QDistinct> {
  QueryBuilder<IsarSampleDTO, IsarSampleDTO, QDistinct> distinctByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title');
    });
  }
}

extension IsarSampleDTOQueryProperty
    on QueryBuilder<IsarSampleDTO, IsarSampleDTO, QQueryProperty> {
  QueryBuilder<IsarSampleDTO, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarSampleDTO, int, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
