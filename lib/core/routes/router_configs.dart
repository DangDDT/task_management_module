// ignore_for_file: void_checks

import 'package:core_picker/core/core_picker.dart';
import 'package:get/get.dart';
import 'package:task_management_module/src/presentation/pages/complete_task/complete_task_controller.dart';
import 'package:task_management_module/src/presentation/pages/complete_task/complete_task_page.dart';
import 'package:task_management_module/src/presentation/pages/list_task/list_task_controller.dart';
import 'package:task_management_module/src/presentation/pages/list_task/list_task_page.dart';
import 'package:task_management_module/src/presentation/pages/task_detail/task_detail_page.dart';
import 'package:task_management_module/src/presentation/pages/task_reminder/task_reminder_page.dart';

import '../../src/presentation/pages/task_detail/task_detail_controller.dart';
import '../../src/presentation/pages/task_reminder/task_reminder_controller.dart';
import 'router_constant.dart';

class ModuleRouter {
  static final List<GetPage> routes = [
    //  GetPage<dynamic>(
    //   name: route_name,
    //   page: () => const PageName(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut(() => PageNameCtrl());
    //     ...
    //   }),
    // ),
    GetPage(
      name: RouteConstants.taskDetailRoute,
      page: () => const TaskDetailPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TaskDetailController());
      }),
    ),
    GetPage(
      name: RouteConstants.taskListRoute,
      page: () => const ListTaskPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ListTaskController());
      }),
    ),
    GetPage(
      name: RouteConstants.completeTaskRoute,
      page: () => const CompleteTaskPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CompleteTaskController());
      }),
    ),
    GetPage(
      name: RouteConstants.taskReminderRoute,
      page: () => const TaskReminderPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TaskReminderController());
      }),
    ),
    ...CorePicker.pageRoutes,
  ];
}
