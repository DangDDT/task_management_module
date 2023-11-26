import 'package:isar/isar.dart';
import 'package:task_management_module/src/domain/models/task_event_reminder.dart';
import 'package:task_management_module/src/domain/entities/task_event_reminder.dart';
import 'package:task_management_module/src/domain/services/local_task_event_reminder_service.dart';

import '../../../domain/mappers/z_mapper.dart';
import 'isar_database.dart';

class LocalTaskEventReminderRepository extends LocalTaskEventReminderService {
  final IsarDatabase _isar = IsarDatabase.instance;
  final Mapper _mapper = Mapper.instance;

  @override
  Future<TaskEventReminderModel> createTaskEventReminder(
    TaskEventReminder taskEventReminder,
  ) async {
    try {
      final id = _isar.database.writeTxnSync<int>(() {
        final id = _isar.database.taskEventReminders.putSync(
          taskEventReminder,
        );
        return id;
      });
      final result = _isar.database.taskEventReminders.getSync(id);
      if (result == null) {
        throw Exception('Create task event reminder failed');
      }
      return _mapper.mapData<TaskEventReminder, TaskEventReminderModel>(
        result,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteTaskEventReminder(String eventId) async {
    try {
      final success = _isar.database.writeTxnSync(() {
        final success = _isar.database.taskEventReminders
            .where()
            .filter()
            .eventIdEqualTo(eventId)
            .deleteFirstSync();
        return success;
      });
      return success;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TaskEventReminderModel> getTaskEventReminderById(
    String eventId,
  ) async {
    try {
      final result = _isar.database.taskEventReminders
          .where()
          .filter()
          .eventIdEqualTo(eventId)
          .findFirstSync();
      if (result == null) {
        throw Exception('Get task event reminder by id failed');
      }
      return _mapper.mapData<TaskEventReminder, TaskEventReminderModel>(
        result,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TaskEventReminderModel>> getTaskEventReminders(
    DateTime eventAt, {
    String? taskId,
    required String userId,
  }) async {
    try {
      if (taskId == null) {
        final result = _isar.database.taskEventReminders
            .where()
            .filter()
            .userIdEqualTo(userId)
            .eventAtBetween(
              DateTime(
                eventAt.year,
                eventAt.month,
                eventAt.day,
                0,
                0,
              ),
              DateTime(
                eventAt.year,
                eventAt.month,
                eventAt.day,
                23,
                59,
              ),
              includeLower: false,
            )
            .findAllSync();
        return _mapper.mapListDataOrDefault<TaskEventReminder,
                TaskEventReminderModel>(
              result,
            ) ??
            [];
      }
      final result = _isar.database.taskEventReminders
          .where()
          .filter()
          .userIdEqualTo(userId)
          .eventAtBetween(
            DateTime(
              eventAt.year,
              eventAt.month,
              eventAt.day,
              0,
              0,
            ),
            DateTime(
              eventAt.year,
              eventAt.month,
              eventAt.day,
              23,
              59,
            ),
            includeLower: false,
          )
          .and()
          .taskIdEqualTo(taskId)
          .findAllSync();
      return _mapper
              .mapListDataOrDefault<TaskEventReminder, TaskEventReminderModel>(
            result,
          ) ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TaskEventReminderModel> updateTaskEventReminder(
    TaskEventReminder taskEventReminder,
  ) async {
    try {
      final task = _isar.database.taskEventReminders
          .filter()
          .eventIdEqualTo(taskEventReminder.eventId);
      final taskFind = task.findFirstSync();
      if (taskFind == null) {
        throw Exception('Update task event reminder failed');
      }
      final updated = _isar.database.writeTxnSync(() {
        final deleteSuccess = task.deleteFirstSync();
        if (!deleteSuccess) {
          return null;
        }
        final id = _isar.database.taskEventReminders.putSync(
          taskEventReminder,
        );
        return id;
      });
      if (updated == null) {
        throw Exception('Update task event reminder failed');
      }
      final result = _isar.database.taskEventReminders
          .where()
          .filter()
          .eventIdEqualTo(taskEventReminder.eventId)
          .findFirstSync();
      if (result == null) {
        throw Exception('Update task event reminder failed');
      }
      return _mapper.mapData<TaskEventReminder, TaskEventReminderModel>(
        result,
      );
    } catch (e) {
      rethrow;
    }
  }
}
