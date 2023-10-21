import '../entities/task_event_reminder.dart';
import '../models/task_event_reminder.dart';

abstract class LocalTaskEventReminderService {
  Future<TaskEventReminderModel> createTaskEventReminder(
    TaskEventReminder taskEventReminder,
  );

  Future<TaskEventReminderModel> updateTaskEventReminder(
    TaskEventReminder taskEventReminder,
  );

  Future<bool> deleteTaskEventReminder(String eventId);

  Future<List<TaskEventReminderModel>> getTaskEventReminders(
    DateTime eventAt, {
    String? taskId,
    required String userId,
  });

  Future<TaskEventReminderModel> getTaskEventReminderById(String eventId);
}
