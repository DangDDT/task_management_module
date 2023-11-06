import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:task_management_module/src/presentation/pages/list_task/list_task_controller.dart';
import 'package:task_management_module/src/presentation/views/list_task/list_task_view.dart';
import 'package:task_management_module/src/presentation/views/list_task/list_task_view_controller.dart';

class ListTaskPage extends GetView<ListTaskController> {
  final List<ListTaskTab>? tabs;
  const ListTaskPage({super.key, this.tabs});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách công việc'),
        ),
        body: const ListTaskView(),
      ),
    );
  }
}
