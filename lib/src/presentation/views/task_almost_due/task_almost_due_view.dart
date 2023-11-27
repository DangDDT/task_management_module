import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_module/src/presentation/widgets/state_render.dart';

import '../../../../core/core.dart';
import '../../../domain/models/task_model.dart';
import '../../widgets/task_wedding_card.dart';

class TaskAlmostDueView extends StatelessWidget {
  final TaskAlmostDueController? controller;
  const TaskAlmostDueView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskAlmostDueController>(
      init: controller ?? TaskAlmostDueController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Công việc cần hoàn thành',
                    style: kTheme.textTheme.headlineSmall,
                  ),
                  kGapW4,
                  Obx(() {
                    int taskCount = 0;
                    final state = controller.taskModels.state.value;
                    if (state.isLoading) {
                      return Text(
                        '(Đang tải)',
                        style: kTheme.textTheme.titleLarge?.copyWith(
                          color: kTheme.colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else if (state.isSuccess) {
                      taskCount = controller.taskModels.data.value.length;
                    }
                    return Text(
                      '($taskCount)',
                      style: kTheme.textTheme.headlineSmall?.copyWith(
                        color: kTheme.colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ],
              ),
            ),
            kGapH4,
            Obx(
              () => StateRender<List<TaskWeddingModel>, TaskWeddingModel>(
                state: controller.taskModels.state.value,
                data: controller.taskModels.data.value,
                layoutBuilder: (context, itemBuilder) {
                  return _SlideBuilder(
                    data: controller.taskModels.data.value,
                    itemBuilder: itemBuilder,
                  );
                },
                itemBuilder: (item, _) {
                  return _TaskAlarmReminderCard(
                    task: item,
                    onTap: () => controller.onTapTaskCard(item),
                  );
                },
                isAnimation: true,
                verticalSlideOffset: 20.0,
                horizontalSlideOffset: 0.0,
              ),
            )
          ],
        );
      },
    );
  }
}

class _SlideBuilder extends GetView<TaskAlmostDueController> {
  const _SlideBuilder({
    required this.data,
    required this.itemBuilder,
  });

  final List<TaskWeddingModel> data;
  final Widget Function(TaskWeddingModel item, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Center(
        child: Column(
          children: [
            kGapH24,
            const Icon(
              Icons.data_array_rounded,
              size: 48,
              color: Colors.grey,
            ),
            kGapH12,
            Text(
              'Không có công việc nào cần hoàn thành',
              style: kTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
    return CarouselSlider.builder(
      itemCount: data.length,
      itemBuilder: (context, index, realIndex) {
        final task = controller.taskModels.data.value[index];
        return itemBuilder(task, index);
      },
      options: CarouselOptions(
        viewportFraction: 0.9,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        enlargeFactor: 1.2,
        autoPlay: true,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        animateToClosest: true,
        autoPlayInterval: const Duration(seconds: 5),
      ),
    );
  }
}

class _TaskAlarmReminderCard extends GetView<TaskAlmostDueController> {
  const _TaskAlarmReminderCard({
    required this.task,
    required this.onTap,
  });
  final TaskWeddingModel task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TaskWeddingCard(
      onTap: onTap,
      taskId: task.id,
      name: task.name,
      description: task.description,
      duedate: task.duedate,
      taskMasterName: task.taskMaster?.name ?? '',
      customerName: task.customer.fullName,
      serviceNames: [task.orderDetail].map((e) => e.service.name).toList(),
      status: task.status,
      config: TaskServiceCardViewConfig(
        isShowCustomerName: false,
        isShowFullName: false,
        isShowServiceName: true,
        isShowStatus: true,
        isShowDescription: false,
        actionConfig: ActionConfig(
          actions: [
            ///TODO: Add action for task
            if (task.status.isTodo)
              ActionItem(
                icon: Icons.play_arrow_rounded,
                actionLabel: 'Bắt đầu thực hiện',
                onTap: () => controller.onStartTask(task.id),
              ),
            if (task.status.isInProgress)
              ActionItem(
                icon: Icons.play_arrow_rounded,
                actionLabel: 'Báo cáo hoàn thành',
                onTap: () => controller.onCompleteTask(task.id),
              ),
          ],
        ),
      ),
    );
  }
}
