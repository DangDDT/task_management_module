// ignore_for_file: unnecessary_overrides

import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:task_management_module/core/core.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../../domain/mock/dummy.dart';
import '../../../domain/models/task_model.dart';
import '../../global/module_controller.dart';
import '../../view_models/state_model.dart';

class TaskAlarmReminderController extends GetxController {
  ///Controllers
  final moduleController =
      Get.find<ModuleController>(tag: ModuleController.tag);

  ///States
  final StateModel<List<TaskWeddingModel>> taskModel = StateModel(
    data: Rx(TaskWeddingModel.loadingList()),
  );

  @override
  onInit() {
    loadTaskProgressData();
    super.onInit();
  }

  Future<void> loadTaskProgressData() async {
    taskModel.loading(loadingData: TaskWeddingModel.loadingList());
    try {
      await Future.delayed(
        Duration(seconds: faker.randomGenerator.integer(5)),
        () {
          final data = Dummy.taskModel;
          taskModel.success(data);
        },
      );
    } catch (e, stackTrace) {
      taskModel.error(
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
    Get.toNamed(
      RouteConstants.taskDetailRoute,
      arguments: {
        'taskId': item.id,
        'name': item.name,
        'description': item.description,
        'duedate': item.duedate,
        'taskMasterName': item.taskMaster.name,
        'serviceName': item.orderDetail.service.name,
        'status': item.status,
      },
    );
  }
}
