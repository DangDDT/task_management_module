// ignore_for_file: unnecessary_overrides

import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../../domain/mock/dummy.dart';
import '../../../domain/models/task_model.dart';
import '../../../domain/requests/get_task_list_param.dart';
import '../../global/module_controller.dart';
import '../../view_models/state_model.dart';

class TaskAlmostDueController extends GetxController {
  ///Controllers
  final moduleController =
      Get.find<ModuleController>(tag: ModuleController.tag);

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
      await Future.delayed(
        Duration(seconds: faker.randomGenerator.integer(5)),
        () {
          final data = Dummy.getDummyTasks(
            GetTaskListParam(
              pageSize: 9999,
              pageIndex: 0,
              duedateFrom: DateTime.now(),
              duedateTo: DateTime.now().add(const Duration(days: 3)),
              taskStatusCodes: [
                TaskProgressEnum.toDo.toCode(),
                TaskProgressEnum.inProgress.toCode(),
              ],
            ),
          );
          taskModels.success(data);
        },
      );
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

  Future<void> onTapTaskCard(TaskWeddingModel item, String heroTag) async {
    await Get.toNamed(
      RouteConstants.taskDetailRoute,
      arguments: {
        'taskId': item.id,
        'name': item.name,
        'description': item.description,
        'duedate': item.duedate,
        'taskMasterName': item.taskMaster?.name,
        'customerName': item.customer.fullName,
        'serviceNames': item.orderDetails.map((e) => e.service.name).toList(),
        'status': item.status,
        'heroTag': heroTag,
      },
    );
  }
}
