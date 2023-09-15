import 'package:isar/isar.dart';
part 'sample_dto.g.dart';

@collection
class IsarSampleDTO {
  static const String nameSchema = 'isar_sample_dto.schema';

  final Id id;

  final int title;

  IsarSampleDTO({required this.id, required this.title});
}
