import 'package:get/get.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';

class TaskDetailController extends GetxController {
  ///Params
  late final dynamic taskId;
  late final String name;
  late final String description;
  late final DateTime duedate;
  late final String taskMasterName;
  late final String customerName;
  late final List<String> serviceNames;
  late final TaskProgressEnum status;
  late final String? heroTag;
  late final Rx<TaskProgressEnum> statusRx = Rx(status);

  @override
  void onInit() {
    super.onInit();
    taskId = Get.arguments['taskId'] ?? -1;
    name = Get.arguments['name'] ?? '';
    description = Get.arguments['description'] ?? '';
    duedate = Get.arguments['duedate'] ?? DateTime.now();
    taskMasterName = Get.arguments['taskMasterName'] ?? '';
    serviceNames = Get.arguments['serviceNames'] ?? '';
    customerName = Get.arguments['customerName'] ?? '';
    status = Get.arguments?['status'] as TaskProgressEnum;
    heroTag = Get.arguments?['heroTag'] as String?;
  }

  Future<void> onStartTask() async {}

  Future<void> onCompleteTask() async {
    final isCompleteDone = await Get.toNamed(
      RouteConstants.completeTaskRoute,
    );
    if (isCompleteDone == null) {
      return;
    }
    if (isCompleteDone) {
      statusRx.value = TaskProgressEnum.done;
    }
  }
}
