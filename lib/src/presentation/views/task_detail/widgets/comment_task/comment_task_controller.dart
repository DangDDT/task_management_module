// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:task_management_module/src/domain/models/task_comment.dart';

import '../../../../../../core/module_configs.dart';
import '../../../../../domain/mock/dummy.dart';
import '../../../../view_models/state_model.dart';

class CommentTaskViewController extends GetxController {
  ///Configs
  final ModuleConfig config = Get.find<ModuleConfig>(tag: ModuleConfig.tag);

  final dynamic taskId;
  CommentTaskViewController({
    required this.taskId,
  });

  ///States
  final StateModel<List<TaskCommentModel>> taskComments = StateModel(
    data: Rx(TaskCommentModel.loadings()),
  );
  final Rx<bool> isShowAll = false.obs;

  @override
  onInit() {
    super.onInit();
    loadTaskCommentDatas();
  }

  Future<void> loadTaskCommentDatas() async {
    taskComments.loading();
    try {
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          final data = Dummy.dummyTaskComments(taskId);
          data.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          taskComments.success(data);
        },
      );
    } catch (e) {
      taskComments.error(
        e.toString(),
        errorData: TaskCommentModel.errors(),
      );
    }
  }
}
