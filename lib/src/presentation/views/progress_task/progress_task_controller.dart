import 'package:get/get.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';
import 'package:task_management_module/src/domain/requests/get_task_progress_param.dart';
import 'package:task_management_module/src/domain/services/task_service.dart';
import 'package:task_management_module/src/presentation/global/module_controller.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../../domain/models/task_progress_model.dart';
import '../../view_models/state_model.dart';

class ProgressTaskController extends GetxController {
  ///Services
  final ITaskService _taskService = Get.find();

  ///Controllers
  final moduleController =
      Get.find<ModuleController>(tag: ModuleController.tag);

  ///States
  final StateModel<List<TaskProgressModel>> taskProgressState = StateModel(
    data: Rx(TaskProgressModel.loadingList()),
  );

  final List<TaskProgressEnum> taskWillShow = [
    TaskProgressEnum.toDo,
    TaskProgressEnum.inProgress,
    TaskProgressEnum.done,
  ];

  @override
  onInit() {
    super.onInit();
    loadTaskProgressData();
  }

  Future<void> loadTaskProgressData() async {
    taskProgressState.loading(loadingData: TaskProgressModel.loadingList());
    try {
      List<TaskProgressModel> data = await _taskService.getTaskProgress(
        GetTaskProgressParam(
          fromDate: null,
          toDate: null,
        ),
      );

      data = data.where((element) {
        return taskWillShow.contains(element.type);
      }).toList();

      taskProgressState.success(data);
    } catch (e, stackTrace) {
      taskProgressState.error(
        e.toString(),
        errorData: TaskProgressModel.errorList(),
      );
      Logger.log(
        e.toString(),
        name: 'ProgressTaskController - loadTaskProgressData()',
        stackTrace: stackTrace,
      );
    }
  }
}
