import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:get/get.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/models/task_model.dart';
import 'package:task_management_module/src/domain/services/local_task_event_reminder_service.dart';
import 'package:task_management_module/src/presentation/shared/toast.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../../domain/entities/task_event_reminder.dart';
import '../../../domain/models/task_event_reminder.dart';
import '../../view_models/state_model.dart';
import 'widgets/add_task_reminder_dialog.dart';

class TaskReminderController extends GetxController {
  late final TaskWeddingModel taskModel;
  late final DateTime? selectedDateParam;

  ///Config
  final ModuleConfig _moduleConfig = Get.find(tag: ModuleConfig.tag);
  late final String userId = _moduleConfig.userConfig.userId.toString();

  ///Services
  final LocalTaskEventReminderService _localTaskEventReminderService =
      Get.find();

  late final Rx<DateTime> selectedDate;

  final StateModel<List<TaskEventReminderModel>> events = StateModel(
    data: Rx(TaskEventReminderModel.loadings()),
  );

  @override
  void onInit() {
    taskModel = Get.arguments['taskModel'] as TaskWeddingModel;
    selectedDateParam = Get.arguments['selectedDate'] as DateTime?;
    selectedDate = Rx(
      selectedDateParam ?? DateTime.now(),
    );
    loadTaskEventReminderModel();
    super.onInit();
  }

  Future<void> onDaySelected(DateTime selected) async {
    selectedDate.value = selected;
    await loadTaskEventReminderModel();
  }

  Future<void> onAddTaskEvent() async {
    await Get.dialog(
      AddTaskReminderDialog(
        title: 'Thêm nhắc nhở',
        addButtonText: 'Thêm',
        onSubmit: (content, isNotify, color, isSync, time) async {
          try {
            final result =
                await _localTaskEventReminderService.createTaskEventReminder(
              TaskEventReminder(
                userId: userId,
                content: content,
                isNotify: isNotify,
                colorCode: color.toHex(),
                taskId: taskModel.id.toString(),
                eventAt: DateTime(
                  selectedDate.value.year,
                  selectedDate.value.month,
                  selectedDate.value.day,
                  time.hour,
                  time.minute,
                ),
                eventId:
                    '${userId}_${taskModel.id}_${selectedDate.value.toIso8601String()}',
              ),
            );
            Get.back();
            if (isNotify) {
              await _moduleConfig.onCreateLocalNotificationCallback?.call(
                result.eventId.hashCode,
                taskModel.name,
                content,
                result.eventAt,
              );
            }
            if (isSync) {
              await _syncWithDevice(result);
            }
            Toast.showSuccess(message: 'Thêm nhắc nhở thành công.');
            await loadTaskEventReminderModel();
          } catch (e, stackTrace) {
            Logger.log(
              e.toString(),
              name: 'TaskReminderController_onAddTaskEvent',
              stackTrace: stackTrace,
            );
            Toast.showError(
              message: 'Thêm nhắc nhở thất bại, vui lòng thử lại sau.',
            );
          }
        },
      ),
    );
  }

  Future<void> _syncWithDevice(TaskEventReminderModel data) async {
    try {
      final Event event = Event(
        title: taskModel.name,
        description: data.content,
        startDate: DateTime(
          data.eventAt.year,
          data.eventAt.month,
          data.eventAt.day,
          0,
          0,
        ),
        endDate: DateTime(
          data.eventAt.year,
          data.eventAt.month,
          data.eventAt.day,
          23,
          59,
        ),
        timeZone: 'UTC',
      );

      await Add2Calendar.addEvent2Cal(event);
    } catch (e) {
      Logger.log(
        e.toString(),
        name: 'TaskReminderController_syncWithDevice',
      );
      rethrow;
    }
  }

  Future<void> loadTaskEventReminderModel() async {
    events.loading(loadingData: TaskEventReminderModel.loadings());
    try {
      final data = await _localTaskEventReminderService.getTaskEventReminders(
        selectedDate.value,
        userId: _moduleConfig.userConfig.userId,
        taskId: taskModel.id.toString(),
      );
      if (data.isEmpty) {
        events.empty(emptyData: List<TaskEventReminderModel>.empty());
        return;
      }
      data.sort((a, b) => b.eventAt.compareTo(a.eventAt));
      events.success(data);
    } catch (e) {
      events.error(
        e.toString(),
        errorData: TaskEventReminderModel.errors(),
      );
    }
  }
}
