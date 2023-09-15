import 'package:get/get.dart';
import 'package:task_management_module/src/domain/models/task_model.dart';
import 'package:task_management_module/src/presentation/view_models/state_model.dart';

import '../../../domain/mock/dummy.dart';

class TaskDetailViewController extends GetxController {
  TaskDetailViewController({required this.id});

  final dynamic id;

  ///States
  final StateModel<TaskWeddingModel> taskModel = StateModel(
    data: Rx(TaskWeddingModel.loading()),
  );

  @override
  onInit() {
    loadTaskDetailModel();
    super.onInit();
  }

  Future<void> loadTaskDetailModel() async {
    taskModel.loading(loadingData: TaskWeddingModel.loading());
    try {
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          final data = Dummy.dummyTaskDetailById(id);
          taskModel.success(data);
        },
      );
    } catch (e) {
      taskModel.error(
        e.toString(),
        errorData: TaskWeddingModel.error(),
      );
    }
  }
}
