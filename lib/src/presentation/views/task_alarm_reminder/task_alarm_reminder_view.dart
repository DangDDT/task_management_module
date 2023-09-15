import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_module/src/presentation/views/task_alarm_reminder/task_alarm_reminder_controller.dart';
import 'package:task_management_module/src/presentation/widgets/state_render.dart';

import '../../../../core/core.dart';
import '../../../domain/models/task_model.dart';
import '../../widgets/task_card.dart';

class TaskAlarmReminderView extends StatelessWidget {
  const TaskAlarmReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskAlarmReminderController>(
      init: TaskAlarmReminderController(),
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
                    'Công việc sắp đến hạn',
                    style: kTheme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  kGapW4,
                  Obx(() {
                    int taskCount = 0;
                    final state = controller.taskModel.state.value;
                    if (state.isLoading) {
                      return Text(
                        '(Đang tải)',
                        style: kTheme.textTheme.titleLarge?.copyWith(
                          color: kTheme.colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else if (state.isSuccess) {
                      taskCount = controller.taskModel.data.value.length;
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
            Obx(() => StateRender<List<TaskWeddingModel>, TaskWeddingModel>(
                  state: controller.taskModel.state.value,
                  data: controller.taskModel.data.value,
                  layoutBuilder: (context, itemBuilder) {
                    return _SlideBuilder(
                      data: controller.taskModel.data.value,
                      itemBuilder: itemBuilder,
                    );
                  },
                  itemBuilder: (item, _) => _TaskAlarmReminderCard(
                    task: item,
                    onTap: () => controller.onTapTaskCard(item),
                  ),
                  isAnimation: true,
                  verticalSlideOffset: 20.0,
                  horizontalSlideOffset: 0.0,
                ))
          ],
        );
      },
    );
  }
}

class _SlideBuilder extends GetView<TaskAlarmReminderController> {
  const _SlideBuilder({
    required this.data,
    required this.itemBuilder,
  });

  final List<TaskWeddingModel> data;
  final Widget Function(TaskWeddingModel item, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: data.length,
      itemBuilder: (context, index, realIndex) {
        final task = controller.taskModel.data.value[index];
        return itemBuilder(task, index);
      },
      options: CarouselOptions(
        viewportFraction: 0.8,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        aspectRatio: 2.2,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        animateToClosest: true,
        autoPlayInterval: const Duration(seconds: 5),
      ),
    );
  }
}

class _TaskAlarmReminderCard extends StatelessWidget {
  const _TaskAlarmReminderCard({
    required this.task,
    required this.onTap,
  });
  final TaskWeddingModel task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'TaskServiceCard_${task.id}',
      child: TaskServiceCard(
        onTap: onTap,
        taskId: task.id,
        name: task.name,
        description: task.description,
        duedate: task.duedate,
        taskMasterName: task.taskMaster.name,
        serviceName: task.orderDetail.service.name,
      ),
    );
  }
}
