import 'package:flutter/material.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/domain.dart';
import 'package:task_management_module/src/domain/models/task_comment.dart';
import 'package:task_management_module/src/presentation/shared/circle_avatar_with_error_handler.dart';
import 'package:task_management_module/src/presentation/widgets/state_render.dart';

class CommentTaskView extends StatefulWidget {
  final dynamic taskId;
  final String fullName;
  final String avatarUrl;
  final List<TaskCommentModel>? items;
  final Future<void> Function(String comment)? onAddComment;

  const CommentTaskView({
    super.key,
    required this.items,
    required this.fullName,
    required this.avatarUrl,
    this.onAddComment,
  }) : taskId = null;

  @override
  State<CommentTaskView> createState() => _CommentTaskViewState();
}

class _CommentTaskViewState extends State<CommentTaskView> {
  final TextEditingController _commentController = TextEditingController();
  bool isShowAll = false;
  void setIsShowAll() {
    setState(() {
      isShowAll = !isShowAll;
    });
  }

  @override
  dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 410),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          _AddCommentTextField(
            fullName: widget.fullName,
            avatarUrl: widget.avatarUrl,
            commentController: _commentController,
            onAddComment: widget.onAddComment,
          ),
          kGapH8,
          StateRender<List<TaskCommentModel>, TaskCommentModel>(
            state: LoadingState.success,
            data: widget.items ?? [],
            layoutBuilder: (data, itemBuilder) => _TaskCommentLayoutBuilder(
              data: data,
              itemBuilder: itemBuilder,
              dataDisplay: isShowAll ? data.length : 3,
            ),
            itemBuilder: (item, index) => _TaskCommentItemView(
              item: item,
            ),
            isAnimation: true,
            horizontalSlideOffset: 0.0,
            verticalSlideOffset: 20.0,
            duration: const Duration(milliseconds: 410),
            emptyBuilder: Center(
              child: Text(
                'Chưa có trao đổi nào',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: kTheme.colorScheme.primary,
                    ),
              ),
            ),
          ),
          if ((widget.items ?? []).length > 3)
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
                onPressed: () => setIsShowAll(),
                child: Text(
                  isShowAll
                      ? 'Thu gọn'
                      : 'Xem tất cả (${(widget.items ?? []).length})',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: kTheme.colorScheme.primary,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddCommentTextField extends StatelessWidget {
  final String fullName;
  final String avatarUrl;
  final TextEditingController commentController;
  final Future<void> Function(String comment)? onAddComment;
  const _AddCommentTextField({
    required this.fullName,
    required this.avatarUrl,
    required this.commentController,
    required this.onAddComment,
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
          Expanded(
            child: TextField(
              controller: commentController,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Nhập trao đổi...',
                border: InputBorder.none,
                fillColor: Colors.transparent,
                filled: true,
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
            onPressed: () async {
              if (commentController.text.isNotEmpty) {
                await onAddComment?.call(commentController.text);
                commentController.clear();
              }
            },
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
