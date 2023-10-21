import 'package:get/get.dart';

import '../../../../core/module_configs.dart';
import '../../../domain/models/task_event_reminder.dart';
import '../../../domain/services/local_task_event_reminder_service.dart';
import '../../view_models/state_model.dart';

class DashboardTaskReminderController extends GetxController {
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
    super.onInit();
    selectedDate = Rx(DateTime.now());
    loadTaskEventReminderModel();
  }

  Future<void> loadTaskEventReminderModel() async {
    events.loading(loadingData: TaskEventReminderModel.loadings());
    try {
      final data = await _localTaskEventReminderService.getTaskEventReminders(
        selectedDate.value,
        userId: _moduleConfig.userConfig.userId,
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
