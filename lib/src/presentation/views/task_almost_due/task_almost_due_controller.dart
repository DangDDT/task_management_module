// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';
import 'package:task_management_module/src/domain/requests/get_task_wedding_param.dart';
import 'package:task_management_module/src/domain/requests/put_status_task_body.dart';
import 'package:task_management_module/src/domain/services/task_service.dart';
import 'package:task_management_module/src/presentation/pages/complete_task/complete_task_controller.dart';
import 'package:task_management_module/src/presentation/shared/toast.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../../domain/models/task_model.dart';
import '../../global/module_controller.dart';
import '../../view_models/state_model.dart';

class TaskAlmostDueController extends GetxController {
  ///Controllers
  final moduleController =
      Get.find<ModuleController>(tag: ModuleController.tag);

  ///Services
  final _taskService = Get.find<ITaskService>();

  ///States
  final StateModel<List<TaskWeddingModel>> taskModels = StateModel(
    data: Rx(TaskWeddingModel.loadingList()),
  );

  @override
  onInit() {
    loadTaskProgressData();
    super.onInit();
  }

  Future<void> loadTaskProgressData() async {
    taskModels.loading(loadingData: TaskWeddingModel.loadingList());
    try {
      final data = await _taskService.getTaskWeddings(
        GetTaskWeddingParam(
          pageSize: null,
          pageIndex: null,
          startDateFrom: DateTime.now().firstTimeOfDate(),
          startDateTo: DateTime.now().lastTimeOfDate(),
          orderBy: null,
          orderType: null,
          taskName: null,
          status: [
            TaskProgressEnum.toDo.toCode(),
            TaskProgressEnum.inProgress.toCode(),
            TaskProgressEnum.done.toCode(),
          ],
        ),
      );
      // Dummy.getDummyTasks(
      //   GetTaskListParam(
      //     pageSize: 9999,
      //     pageIndex: 0,
      //     duedateFrom: DateTime.now(),
      //     duedateTo: DateTime.now().add(const Duration(days: 3)),
      //     taskStatusCodes: [
      //       TaskProgressEnum.toDo.toCode(),
      //       TaskProgressEnum.inProgress.toCode(),
      //     ],
      //   ),
      // );
      taskModels.success(data);
    } catch (e, stackTrace) {
      taskModels.error(
        e.toString(),
        errorData: TaskWeddingModel.errorList(),
      );
      Logger.log(
        e.toString(),
        name: 'ProgressTaskController - loadTaskProgressData()',
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> onTapTaskCard(TaskWeddingModel item) async {
    await Get.toNamed(
      RouteConstants.taskDetailRoute,
      arguments: {
        'taskId': item.id,
        'name': item.name,
        'description': item.description,
        'duedate': item.duedate,
        'taskMasterName': item.taskMaster?.name,
        'customerName': item.customer.fullName,
        'serviceNames': [item.orderDetail].map((e) => e.service.name).toList(),
        'status': item.status,
      },
    );
  }

  Future<void> onStartTask(String taskId) async {
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
        Toast.showSuccess(message: 'Bắt đầu công việc thành công');
        await loadTaskProgressData();
      } else {
        Toast.showError(message: 'Bắt đầu công việc thất bại');
      }
    } catch (e) {
      Logger.log(e.toString(), name: 'TaskDetailController - onStartTask()');
      Toast.showError(message: 'Có lỗi xảy ra, vui lòng thử lại sau');
    }
  }

  Future<void> onCompleteTask(String taskId) async {
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
      await loadTaskProgressData();
    }
  }
}
