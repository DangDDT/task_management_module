import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/models/task_comment.dart';
import 'package:task_management_module/src/presentation/shared/circle_avatar_with_error_handler.dart';
import 'package:task_management_module/src/presentation/widgets/state_render.dart';

import 'comment_task_controller.dart';

class CommentTaskView extends GetView<CommentTaskViewController> {
  final dynamic taskId;
  const CommentTaskView({
    super.key,
    required this.taskId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentTaskViewController>(
      init: CommentTaskViewController(
        taskId: taskId,
      ),
      tag: 'CommentTaskViewController-${taskId.toString()}',
      builder: (controller) {
        return Obx(
          () => AnimatedSize(
            duration: const Duration(milliseconds: 410),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                _AddCommentTextField(
                  fullName: controller.config.userConfig.fullName,
                  avatarUrl: controller.config.userConfig.avatar,
                ),
                kGapH8,
                StateRender<List<TaskCommentModel>, TaskCommentModel>(
                  state: controller.taskComments.state.value,
                  data: controller.taskComments.data.value,
                  layoutBuilder: (data, itemBuilder) =>
                      _TaskCommentLayoutBuilder(
                    data: controller.taskComments.data.value,
                    itemBuilder: itemBuilder,
                    dataDisplay: controller.isShowAll.value
                        ? controller.taskComments.data.value.length
                        : 3,
                  ),
                  itemBuilder: (item, index) => _TaskCommentItemView(
                    item: item,
                  ),
                  isAnimation: true,
                  horizontalSlideOffset: 0.0,
                  verticalSlideOffset: 20.0,
                  duration: const Duration(milliseconds: 410),
                ),
                if (controller.taskComments.data.value.length > 3)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: FilledButton.tonal(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 32),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () => controller.isShowAll.toggle(),
                      child: Text(
                        controller.isShowAll.value
                            ? 'Thu gọn'
                            : 'Xem tất cả (${controller.taskComments.data.value.length})',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: kTheme.colorScheme.primary,
                            ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AddCommentTextField extends StatelessWidget {
  final String fullName;
  final String avatarUrl;
  const _AddCommentTextField({
    required this.fullName,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        color: kTheme.colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatarWithErrorHandler(
            radius: 16,
            avatarUrl: avatarUrl,
            fullName: fullName,
          ),
          kGapW12,
          const Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Nhập trao đổi...',
                border: InputBorder.none,
              ),
            ),
          ),
          kGapW12,
          FilledButton.tonal(
            style: FilledButton.styleFrom(
              minimumSize: const Size(32, 32),
              padding: const EdgeInsets.all(0.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed: () {},
            child: Icon(
              Icons.send,
              size: 16,
              color: kTheme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCommentLayoutBuilder extends StatelessWidget {
  final List<TaskCommentModel> data;
  final Widget Function(TaskCommentModel item, int index) itemBuilder;
  final int dataDisplay;
  const _TaskCommentLayoutBuilder({
    required this.data,
    required this.itemBuilder,
    required this.dataDisplay,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 0.0,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dataDisplay > data.length ? data.length : dataDisplay,
      itemBuilder: (context, index) {
        return itemBuilder(
          data[index],
          index,
        );
      },
      separatorBuilder: (context, index) => kGapH12,
    );
  }
}

class _TaskCommentItemView extends StatelessWidget {
  final TaskCommentModel item;
  const _TaskCommentItemView({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: kTheme.colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatarWithErrorHandler(
            radius: 16,
            avatarUrl: item.creator.avatar,
            fullName: item.creator.fullName,
          ),
          kGapW12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.creator.fullName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                kGapH4,
                Text(
                  item.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                kGapH4,
                Text(
                  item.createdAt.toRecentlyString(),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
