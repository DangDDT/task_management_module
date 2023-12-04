import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_preview/image_preview.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/core/utils/helpers/logger.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';
import 'package:task_management_module/src/domain/requests/put_status_task_body.dart';
import 'package:task_management_module/src/domain/services/task_service.dart';
import 'package:task_management_module/src/presentation/pages/complete_task/complete_task_controller.dart';
import 'package:task_management_module/src/presentation/shared/toast.dart';

class TaskDetailController extends GetxController {
  ///Services
  final ITaskService _taskService = Get.find();

  ///Params
  late final dynamic taskId;
  late final String code;
  late final String name;
  late final String description;
  late final DateTime duedate;
  late final String taskMasterName;
  late final String customerName;
  late final List<String> serviceNames;
  late final TaskProgressEnum status;
  late final Rx<String>? imageEvidenceUrl;
  late final Rx<TaskProgressEnum> statusRx = Rx(status);

  @override
  void onInit() {
    super.onInit();
    taskId = Get.arguments['taskId'] ?? -1;
    code = Get.arguments['code'] ?? '';
    name = Get.arguments['name'] ?? '';
    description = Get.arguments['description'] ?? '';
    duedate = Get.arguments['duedate'] ?? DateTime.now();
    taskMasterName = Get.arguments['taskMasterName'] ?? '';
    serviceNames = Get.arguments['serviceNames'] ?? '';
    customerName = Get.arguments['customerName'] ?? '';
    imageEvidenceUrl = Rx(Get.arguments['imageEvidenceUrl'] ?? '');
    status = Get.arguments?['status'] as TaskProgressEnum;
  }

  Future<void> onStartTask() async {
    try {
      final confirm = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có chắc chắn muốn bắt đầu công việc này?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Đồng ý'),
            ),
          ],
        ),
      );
      if (confirm == null || !confirm) {
        return;
      }
      final result = await _taskService.putStatusTask(
        taskId,
        PutStatusTaskBody(
          status: TaskProgressEnum.inProgress.toCode(),
          imageEvidenceUrl: null,
        ),
      );
      if (result) {
        statusRx.value = TaskProgressEnum.inProgress;
        Toast.showSuccess(message: 'Bắt đầu công việc thành công');
      } else {
        Toast.showError(message: 'Bắt đầu công việc thất bại');
      }
    } catch (e) {
      Logger.log(e.toString(), name: 'TaskDetailController - onStartTask()');
      Toast.showError(message: 'Có lỗi xảy ra, vui lòng thử lại sau');
    }
  }

  Future<void> onCompleteTask() async {
    final isCompleteDone = await Get.toNamed(
      RouteConstants.completeTaskRoute,
      arguments: {
        'taskId': taskId,
      },
    ) as ReturnCompleteTask?;
    if (isCompleteDone == null) {
      return;
    }
    if (isCompleteDone.isCompleteDone) {
      statusRx.value = TaskProgressEnum.done;
      imageEvidenceUrl!.value = isCompleteDone.imageEvidenceUrl ?? '';
    }
  }

  Future<void> onShowImageEvidence() async {
    final context = Get.context;
    if (context == null) {
      return;
    }
    if (imageEvidenceUrl == null || imageEvidenceUrl!.isEmpty) {
      Toast.showInfo(message: 'Không có hình ảnh báo cáo');
      return;
    }
    openImagesPage(
      Navigator.of(context),
      imgUrls: [imageEvidenceUrl!.value],
    );
  }
}
