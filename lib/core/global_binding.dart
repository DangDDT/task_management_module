// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:task_management_module/src/domain/mappers/profiles/task_progress_mapper.dart';
import 'package:task_management_module/src/domain/mappers/profiles/task_wedding_mapper.dart';
import 'package:task_management_module/src/domain/mappers/profiles/uploaded_file_mapper.dart';
import 'package:task_management_module/src/domain/services/local_note_service.dart';
import 'package:task_management_module/src/domain/services/task_service.dart';
import 'package:task_management_module/src/infrastructure/repositories/task_repository.dart';
import 'package:task_management_module/src/presentation/views/list_task/list_task_view_controller.dart';

import '../src/domain/domain.dart';
import '../src/domain/mappers/profiles/task_event_reminder_mapper.dart';
import '../src/domain/mappers/profiles/task_note_mapper.dart';
import '../src/domain/services/local_task_event_reminder_service.dart';
import '../src/infrastructure/local_databases/isar/local_note_repository.dart';
import '../src/infrastructure/local_databases/isar/local_task_event_reminder_repository.dart';
import '../src/presentation/global/module_controller.dart';
import 'module_configs.dart';

class GlobalBinding {
  static Future<void> setUpLocator({
    required bool isShowLog,
    required BaseUrlConfig baseUrlConfig,
    OnCreateLocalNotifyCallback? onCreateLocalNotificationCallback,
    List<ListTaskTab>? listTaskTabs,
  }) async {
    Get
      ..put<ModuleConfig>(
        ModuleConfig(
          isShowLog: isShowLog,
          baseUrlConfig: baseUrlConfig,
          onCreateLocalNotificationCallback: onCreateLocalNotificationCallback,
        ),
        tag: ModuleConfig.tag,
      )
      ..put<ModuleController>(
        ModuleController(),
        tag: ModuleController.tag,
      );

    Mapper.instance.registerMappers([
      TaskNoteMapper(),
      TaskEventReminderMapper(),
      TaskProgressMapper(),
      TaskWeddingMapper(),
      UploadedFileMapper(),
    ]);

    Get.put<LocalNoteService>(
      LocalNoteRepository(),
    );
    Get.put<LocalTaskEventReminderService>(
      LocalTaskEventReminderRepository(),
    );
    Get.put<ITaskService>(
      TaskService(),
    );
  }
}
