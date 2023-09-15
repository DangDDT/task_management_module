// ignore_for_file: void_checks

import 'package:get/get.dart';
import 'package:task_management_module/src/presentation/pages/task_detail/task_detail_page.dart';

import '../../src/presentation/pages/task_detail/task_detail_controller.dart';
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
  ];
}
