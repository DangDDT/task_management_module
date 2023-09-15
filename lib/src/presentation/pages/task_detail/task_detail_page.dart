// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/presentation/pages/task_detail/task_detail_controller.dart';

import '../../../domain/enums/private/task_categories_enum.dart';
import '../../views/task_detail/task_detail_view.dart';

class TaskDetailPage extends GetView<TaskDetailController> {
  const TaskDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết công việc'),
      ),
      body: TaskDetailView(
        taskId: controller.taskId,
        name: controller.name,
        description: controller.description,
        duedate: controller.duedate,
        taskMasterName: controller.taskMasterName,
        serviceName: controller.serviceName,
      ),
      persistentFooterAlignment: AlignmentDirectional.topCenter,
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                text: 'Trạng thái: ',
                children: [
                  TextSpan(
                    text: controller.status?.name ?? 'Không có dữ liệu',
                    style: kTheme.textTheme.bodyLarge?.copyWith(
                      color: controller.status?.color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Builder(builder: (context) {
              switch (controller.status) {
                case TaskProgressEnum.toDo:
                  return _EditProgressButton(
                    label: 'Bắt đầu công việc',
                    onPressed: () {
                      Get.back();
                    },
                  );
                case TaskProgressEnum.inProgress:
                  return _EditProgressButton(
                    label: 'Hoàn thành công việc',
                    onPressed: () {
                      Get.back();
                    },
                  );
                case TaskProgressEnum.done:
                  return const SizedBox(width: 0);
                default:
                  return const SizedBox(width: 0);
              }
            }),
          ],
        ),
      ],
    );
  }
}

class _EditProgressButton extends StatelessWidget {
  const _EditProgressButton({
    required this.label,
    this.onPressed,
  });
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: kTheme.textTheme.bodyMedium?.copyWith(
          color: kTheme.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
