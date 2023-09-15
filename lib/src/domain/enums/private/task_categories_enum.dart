import 'package:flutter/material.dart';
import 'package:task_management_module/core/core.dart';

enum TaskProgressEnum {
  all('Tất cả'),
  toDo('Mới giao'),
  inProgress('Đang thực hiện'),
  done('Đã hoàn thành');

  final String name;

  const TaskProgressEnum(this.name);

  bool get isTodo => this == TaskProgressEnum.toDo;

  bool get isInProgress => this == TaskProgressEnum.inProgress;

  bool get isDone => this == TaskProgressEnum.done;

  static TaskProgressEnum fromCode(String code) {
    switch (code) {
      case 'TO_DO':
        return TaskProgressEnum.toDo;
      case 'IN_PROGRESS':
        return TaskProgressEnum.inProgress;
      case 'DONE':
        return TaskProgressEnum.done;

      default:
        return TaskProgressEnum.all;
    }
  }

  Color get color {
    switch (this) {
      case TaskProgressEnum.toDo:
        return Colors.grey;
      case TaskProgressEnum.inProgress:
        return kTheme.colorScheme.primary;
      case TaskProgressEnum.done:
        return Colors.green;
      default:
        return Colors.white;
    }
  }
}
