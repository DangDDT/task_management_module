import 'package:flutter/material.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/models/task_event_reminder.dart';

class NormalListBuilder extends StatelessWidget {
  final List<TaskEventReminderModel> data;
  const NormalListBuilder({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _TaskEventLayoutBuilder(
        data: data,
        itemBuilder: (item, index) => _TaskEventItem(
          item: item,
          index: index,
        ),
      ),
    );
  }
}

class _TaskEventLayoutBuilder extends StatelessWidget {
  final List<TaskEventReminderModel> data;
  final Widget Function(TaskEventReminderModel item, int index) itemBuilder;
  const _TaskEventLayoutBuilder({
    required this.data,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // to disable ListView's scroll
      itemCount: data.length,
      itemBuilder: (context, index) => itemBuilder(
        data[index],
        index,
      ),
      separatorBuilder: (context, index) => kGapH8,
    );
  }
}

class _TaskEventItem extends StatelessWidget {
  final TaskEventReminderModel item;
  final int index;
  const _TaskEventItem({
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: item.color.withOpacity(.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      leading: CircleAvatar(
        radius: 12,
        child: Text(
          '${index + 1}',
          style: kTheme.textTheme.bodyMedium?.copyWith(
            color: kTheme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
      title: Text(
        item.content,
        style: kTheme.textTheme.titleMedium?.copyWith(
          color: kTheme.colorScheme.onSurface.withOpacity(0.6),
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: item.isNotify
                  ? item.createdAt.toFullString()
                  : item.createdAt.toDateReadable(),
              style: kTheme.textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const WidgetSpan(
              child: SizedBox(width: 8),
            ),
            if (item.isNotify)
              WidgetSpan(
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kTheme.colorScheme.primaryContainer,
                  ),
                  child: Icon(
                    Icons.notifications,
                    size: 14,
                    color: kTheme.colorScheme.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
