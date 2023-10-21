import 'package:flutter/material.dart';
import 'package:task_management_module/src/domain/models/task_event_reminder.dart';

import 'widget/horizontal_list_card_view.dart';
import 'widget/normal_list_view.dart';

enum TaskReminderViewType {
  normalList,
  horizontalListCard,
}

class TaskReminderView extends StatelessWidget {
  final TaskReminderViewType type;
  final List<TaskEventReminderModel> data;
  final Function(TaskEventReminderModel item, int index)? onTap;

  const TaskReminderView({
    super.key,
    required this.data,
  })  : type = TaskReminderViewType.normalList,
        onTap = null;

  const TaskReminderView.horizontalListCard({
    super.key,
    required this.data,
    this.onTap,
  }) : type = TaskReminderViewType.horizontalListCard;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case TaskReminderViewType.normalList:
        return NormalListBuilder(data: data);
      case TaskReminderViewType.horizontalListCard:
        return HorizontalListCardBuilder(
          data: data,
          onTap: onTap,
        );
    }
  }
}
