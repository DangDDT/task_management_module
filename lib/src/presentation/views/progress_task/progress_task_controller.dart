import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:task_management_module/src/presentation/global/module_controller.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../../domain/mock/dummy.dart';
import '../../../domain/models/task_progress_model.dart';
import '../../view_models/state_model.dart';

class ProgressTaskController extends GetxController {
  ///Controllers
  final moduleController =
      Get.find<ModuleController>(tag: ModuleController.tag);

  ///States
  final StateModel<List<TaskProgressModel>> taskProgressState = StateModel(
    data: Rx(TaskProgressModel.loadingList()),
  );

  @override
  onInit() {
    super.onInit();
    loadTaskProgressData();
  }

  Future<void> loadTaskProgressData() async {
    taskProgressState.loading(loadingData: TaskProgressModel.loadingList());
    try {
      await Future.delayed(Duration(seconds: faker.randomGenerator.integer(3)));
      final List<TaskProgressModel> data = Dummy.dummyTaskProgress();
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
