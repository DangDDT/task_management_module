import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/models/task_progress_model.dart';

import '../../widgets/state_render.dart';

class ProgressTaskView extends StatelessWidget {
  final ProgressTaskController? controller;
  const ProgressTaskView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressTaskController>(
      init: controller ?? ProgressTaskController(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Thống kê tiến độ công việc',
                style: kTheme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            kGapH8,
            Obx(
              () => StateRender<List<TaskProgressModel>, TaskProgressModel>(
                state: controller.taskProgressState.state.value,
                data: controller.taskProgressState.data.value,
                itemBuilder: (item, _) => _TaskProgressCard(item: item),
                layoutBuilder: (data, itemBuilder) => _ProgressCardGridView(
                  data: data,
                  itemBuilder: itemBuilder,
                ),
                isAnimation: true,
                horizontalSlideOffset: 0,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProgressCardGridView extends StatelessWidget {
  final List<TaskProgressModel> data;
  final Widget Function(TaskProgressModel item, int index) itemBuilder;
  const _ProgressCardGridView({
    required this.data,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    const kPadding = 8.0;
    return SizedBox(
      height: 140.0,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) => SizedBox(
          width: (MediaQuery.of(context).size.width - kPadding * 2) / 3,
          child: itemBuilder(data[index], index),
        ),
      ),
    );
  }
}

class _TaskProgressCard extends StatelessWidget {
  final TaskProgressModel item;
  const _TaskProgressCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: item.color.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                item.name,
                style: kTheme.textTheme.titleMedium?.copyWith(
                  color: item.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              item.value.numToReadableString(),
              style: kTheme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '(công việc)',
              style: kTheme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
