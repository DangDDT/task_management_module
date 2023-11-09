// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:task_management_module/core/module_configs.dart';

class CommentTaskViewController extends GetxController {
  ///Configs
  final ModuleConfig config = Get.find<ModuleConfig>(tag: ModuleConfig.tag);

  final Rx<bool> isShowAll = false.obs;
}
