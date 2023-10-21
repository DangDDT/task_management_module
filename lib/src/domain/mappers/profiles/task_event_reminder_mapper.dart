import '../../entities/task_event_reminder.dart';
import '../../models/task_event_reminder.dart';
import '../base/base_data_mapper_profile.dart';
import '../z_mapper.dart';

class TaskEventReminderMapper
    extends BaseDataMapperProfile<TaskEventReminder, TaskEventReminderModel> {
  @override
  TaskEventReminderModel mapData(TaskEventReminder entity, Mapper mapper) {
    return TaskEventReminderModel(
      id: entity.id,
      colorCode: entity.colorCode,
      content: entity.content,
      createdAt: entity.createdAt,
      eventAt: entity.eventAt,
      eventId: entity.eventId,
      isNotify: entity.isNotify,
      refId: entity.taskId,
    );
  }
}
