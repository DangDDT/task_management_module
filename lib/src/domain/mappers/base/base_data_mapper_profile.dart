import '../../domain.dart';

abstract class BaseDataMapperProfile<Src, Dest> {
  ///The data mapper method
  ///
  ///Override this method to handle how the data will be mapped.
  Dest mapData(Src entity, Mapper mapper);

  ///Override this method to handle the list data mapping
  ///
  ///If not overridden, the default mapper will be used
  List<Dest> mapListData(List<Src> entities, Mapper mapper) {
    return entities.map((e) => mapData(e, mapper)).toList();
  }
}

// mixin DataMapperMixin<Src, Dest> on BaseDataMapperProfile<Src, Dest> {
//   @override
//   Dest mapData(Src? entity, Mapper mapper);

//   @override
//   List<Dest> mapListData(List<Src>? entities, Mapper mapper) {
//     return entities?.map((e) => mapData(e, mapper)).toList() ?? List.empty();
//   }

//   Src mapToData(Dest entity);

//   Src? mapToNullableData(Dest? entity) {
//     if (entity == null) {
//       return null;
//     }

//     return mapToData(entity);
//   }

//   List<Src>? mapToNullableListData(List<Dest>? listEntity) {
//     return listEntity?.map(mapToData).toList();
//   }

//   List<Src> mapToListData(List<Dest>? listEntity) {
//     return mapToNullableListData(listEntity) ?? List.empty();
//   }
// }
