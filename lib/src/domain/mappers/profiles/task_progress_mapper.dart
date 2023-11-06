import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/domain.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';
import 'package:task_management_module/src/domain/models/task_progress_model.dart';
import 'package:wss_repository/entities/task_count.dart';

class TaskProgressMapper
    extends BaseDataMapperProfile<TaskCount, TaskProgressModel> {
  @override
  TaskProgressModel mapData(TaskCount entity, Mapper mapper) {
    return TaskProgressModel(
      id: entity.code ?? DefaultValueMapperConstants.defaultStringValue,
      code: entity.code ?? DefaultValueMapperConstants.defaultStringValue,
      name: entity.name ?? DefaultValueMapperConstants.defaultStringValue,
      value: entity.value ?? DefaultValueMapperConstants.defaultIntValue,
      description: 'công việc',
      type: TaskProgressEnum.fromCode(entity.code ?? ''),
    );
  }
}
