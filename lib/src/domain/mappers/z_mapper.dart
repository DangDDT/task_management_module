import 'base/base_data_mapper_profile.dart';

///Mapper for mappings data
///
///Call
class Mapper {
  Mapper._();
  static Mapper _instance = Mapper._();

  ///The mapper instance
  ///
  ///Use this instance to register mappers and map data
  static Mapper get instance => _instance;

  final List<BaseDataMapperProfile> _mappers = [];

  ///Register a list of [BaseDataMapperProfile]
  ///
  ///If the mapper is already registered, throw an exception
  void registerMappers(List<BaseDataMapperProfile> mappers) {
    for (BaseDataMapperProfile mapper in mappers) {
      if (instance._mappers.contains(mapper)) {
        throw new Exception('Mapper already registered');
      }
      _mappers.add(mapper);
    }
  }

  ///Map the given `TSrc` instance to the `TDest` instance.
  ///
  ///If the mapper profile is not registered,
  ///throw an `UnimplementedError`.
  TDest mapData<TSrc, TDest>(TSrc entity) {
    if (null is TDest && entity == null) {
      return null as TDest;
    }
    for (final mapper in instance._mappers) {
      if (mapper is BaseDataMapperProfile<TSrc, TDest>) {
        return mapper.mapData(entity, this);
      }
    }
    throw UnimplementedError('No mapper found for $entity');
  }

  ///Map list of [TSrc] to list of [TDest]
  ///
  ///If the input list is empty, use `mapListDataOrNull` method
  List<TDest> mapListData<TSrc, TDest>(List<TSrc> entities) {
    for (final mapper in instance._mappers) {
      if (mapper is BaseDataMapperProfile<TSrc, TDest>) {
        return mapper.mapListData(entities, this);
      }
    }
    throw UnimplementedError('No mapper found for $entities');
  }

  ///Map list of [TSrc] to [TDest] or return null if [entities] is null
  ///
  ///If the input list is null, the `orDefault` function will be used.
  ///If not provided, return [null].
  List<TDest>? mapListDataOrDefault<TSrc, TDest>(
    List<TSrc>? entities, {
    List<TDest>? Function()? orDefault,
  }) {
    if (entities == null) return orDefault?.call();

    for (final mapper in instance._mappers) {
      if (mapper is BaseDataMapperProfile<TSrc, TDest>) {
        return mapper.mapListData(entities, this);
      }
    }
    throw UnimplementedError('No mapper found for $entities');
  }
}
