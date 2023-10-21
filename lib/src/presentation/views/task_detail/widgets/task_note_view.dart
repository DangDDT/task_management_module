import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/models/task_note.dart';
import 'package:task_management_module/src/presentation/widgets/state_render.dart';

import '../task_detail_view_controller.dart';

class TaskNoteView extends GetView<TaskDetailViewController> {
  const TaskNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSize(
        duration: const Duration(milliseconds: 410),
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.solidNoteSticky,
                        color: kTheme.colorScheme.primary,
                        size: 24,
                      ),
                      kGapW8,
                      Text(
                        'Ghi chú công việc',
                        style: kTheme.textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  kGapW8,
                  Row(
                    children: [
                      IconButton.filledTonal(
                        style: IconButton.styleFrom(
                          minimumSize: const Size.square(28),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(8),
                        ),
                        onPressed: controller.addNote,
                        icon: Icon(
                          Icons.add,
                          color: kTheme.colorScheme.primary,
                          size: 18,
                        ),
                      ),
                      IconButton.filledTonal(
                        style: IconButton.styleFrom(
                          minimumSize: const Size.square(28),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(8),
                        ),
                        onPressed: () => controller.isShowAllNote.toggle(),
                        icon: Icon(
                          controller.isShowAllNote.value
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: kTheme.colorScheme.primary,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              kGapH8,
              StateRender<List<TaskNoteModel>, TaskNoteModel>(
                state: controller.notes.state.value,
                data: controller.notes.data.value,
                layoutBuilder: (
                  data,
                  itemBuilder,
                ) =>
                    _TaskNoteLayoutBuilder(
                  data: controller.notes.data.value,
                  itemBuilder: itemBuilder,
                  dataDisplay: controller.isShowAllNote.value
                      ? controller.notes.data.value.length
                      : 3,
                ),
                itemBuilder: (item, index) => _TaskNoteItemView(
                  item: item,
                  index: index,
                  onDelete: controller.deleteNote,
                  onEdit: controller.updateNote,
                ),
                emptyBuilder: const Center(
                  child: Column(
                    children: [
                      Text('Hiện tại chưa có ghi chú nào'),
                      kGapH8,
                      Text('Hãy thêm ghi chú mới'),
                    ],
                  ),
                ),
              ),
              if (controller.notes.data.value.length > 3)
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
                    onPressed: () => controller.isShowAllNote.toggle(),
                    child: Text(
                      controller.isShowAllNote.value
                          ? 'Thu gọn'
                          : 'Xem tất cả (${controller.notes.data.value.length})',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: kTheme.colorScheme.primary,
                          ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskNoteLayoutBuilder extends StatelessWidget {
  final List<TaskNoteModel> data;
  final Widget Function(TaskNoteModel item, int index) itemBuilder;
  final int dataDisplay;
  const _TaskNoteLayoutBuilder({
    required this.data,
    required this.itemBuilder,
    required this.dataDisplay,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: dataDisplay > data.length ? data.length : dataDisplay,
      itemBuilder: (context, index) => itemBuilder(
        data[index],
        index,
      ),
    );
  }
}

class _TaskNoteItemView extends StatelessWidget {
  final TaskNoteModel item;
  final int index;
  final Function(TaskNoteModel item) onDelete;
  final Function(TaskNoteModel item) onEdit;
  const _TaskNoteItemView({
    required this.item,
    required this.index,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 12,
        child: Text('${index + 1}', style: kTheme.textTheme.bodySmall),
      ),
      title: Text(item.content, style: kTheme.textTheme.titleMedium),
      subtitle: Text(
        item.createdAt.toFullString(),
        style: kTheme.textTheme.bodySmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.filledTonal(
            style: IconButton.styleFrom(
              minimumSize: const Size.square(32),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
            ),
            onPressed: () => onDelete(item),
            icon: Icon(
              size: 16,
              Icons.close,
              color: kTheme.colorScheme.error,
            ),
          ),
          IconButton.filledTonal(
            style: IconButton.styleFrom(
              minimumSize: const Size.square(32),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
            ),
            onPressed: () => onEdit(item),
            icon: Icon(
              size: 16,
              Icons.edit,
              color: kTheme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
