import '../dtos/sample_dto.dart';

abstract class IsarSampleDAO {
  Future<void> insertSample(IsarSampleDTO dto);
}
