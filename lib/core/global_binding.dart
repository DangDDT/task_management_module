// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:task_management_module/src/domain/services/local_note_service.dart';

import '../src/domain/domain.dart';
import '../src/domain/mappers/profiles/task_event_reminder_mapper.dart';
import '../src/domain/mappers/profiles/task_note_mapper.dart';
import '../src/domain/services/local_task_event_reminder_service.dart';
import '../src/infrastructure/infrastructure.dart';
import '../src/infrastructure/local_databases/isar/local_note_repository.dart';
import '../src/infrastructure/local_databases/isar/local_task_event_reminder_repository.dart';
import '../src/presentation/global/module_controller.dart';
import 'module_configs.dart';

class GlobalBinding {
  static Future<void> setUpLocator({
    required bool isShowLog,
    required BaseUrlConfig baseUrlConfig,
    OnCreateLocalNotifyCallback? onCreateLocalNotificationCallback,
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
    ]);

    final dioClient = Get.put<DioClient>(
      DioClient(
        baseUrl: baseUrlConfig.baseUrl,
      ),
      tag: DioClient.tag,
    );

    ///TODO: ApiClient

    ///TODO: Services
    Get.put<LocalNoteService>(
      LocalNoteRepository(),
    );
    Get.put<LocalTaskEventReminderService>(
      LocalTaskEventReminderRepository(),
    );
  }
}
