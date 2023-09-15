import 'package:get/get.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';

class TaskDetailController extends GetxController {
  ///Params
  late final dynamic taskId;
  late final String name;
  late final String description;
  late final DateTime duedate;
  late final String taskMasterName;
  late final String serviceName;
  late final TaskProgressEnum? status;

  @override
  void onInit() {
    super.onInit();
    taskId = Get.arguments['taskId'] ?? -1;
    name = Get.arguments['name'] ?? '';
    description = Get.arguments['description'] ?? '';
    duedate = Get.arguments['duedate'] ?? DateTime.now();
    taskMasterName = Get.arguments['taskMasterName'] ?? '';
    serviceName = Get.arguments['serviceName'] ?? '';
    status = Get.arguments?['status'] as TaskProgressEnum?;
  }
}
