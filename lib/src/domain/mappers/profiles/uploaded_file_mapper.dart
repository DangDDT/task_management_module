import 'package:task_management_module/core/constants/default_value_mapper_constants.dart';
import 'package:task_management_module/src/domain/domain.dart';
import 'package:task_management_module/src/domain/models/uploaded_file_model.dart';
import 'package:wss_repository/entities/uploaded_file.dart';

class UploadedFileMapper
    extends BaseDataMapperProfile<UploadedFile, UploadedFileModel> {
  @override
  UploadedFileModel mapData(UploadedFile entity, Mapper mapper) {
    return UploadedFileModel(
      filename:
          entity.filename ?? DefaultValueMapperConstants.defaultStringValue,
      link: entity.link ?? DefaultValueMapperConstants.defaultStringValue,
      size: entity.size ?? DefaultValueMapperConstants.defaultStringValue,
      type: entity.type ?? DefaultValueMapperConstants.defaultStringValue,
    );
  }
}
