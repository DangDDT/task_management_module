import 'dart:math';

import 'package:flutter/material.dart';

enum TaskProgressEnum {
  all('Tất cả', 'ALL'),
  expected('Dự kiến', 'EXPECTED'),
  toDo('Mới giao', 'TO_DO'),
  inProgress('Đang thực hiện', 'IN_PROGRESS'),
  done('Đã hoàn thành', 'DONE');

  final String name;
  final String code;

  const TaskProgressEnum(this.name, this.code);

  bool get isAll => this == TaskProgressEnum.all;

  bool get isExpected => this == TaskProgressEnum.expected;

  bool get isTodo => this == TaskProgressEnum.toDo;

  bool get isInProgress => this == TaskProgressEnum.inProgress;

  bool get isDone => this == TaskProgressEnum.done;

  String toCode() {
    switch (this) {
      case TaskProgressEnum.expected:
        return 'EXPECTED';
      case TaskProgressEnum.toDo:
        return 'TO_DO';
      case TaskProgressEnum.inProgress:
        return 'IN_PROGRESS';
      case TaskProgressEnum.done:
        return 'DONE';
      default:
        return '';
    }
  }

  static TaskProgressEnum fromCode(String code) {
    switch (code) {
      case 'TO_DO' || 'TO DO' || 'TODO' || 'Todo':
        return TaskProgressEnum.toDo;
      case 'IN_PROGRESS' || 'INPROGRESS' || 'In Progress' || 'Inprogress':
        return TaskProgressEnum.inProgress;
      case 'DONE' || 'Done' || 'done':
        return TaskProgressEnum.done;
      case 'EXPECTED' || 'Expected' || 'expected':
        return TaskProgressEnum.expected;
      default:
        return TaskProgressEnum.all;
    }
  }

  Color get color {
    switch (this) {
      case TaskProgressEnum.expected:
        return Colors.grey;
      case TaskProgressEnum.toDo:
        return Colors.grey;
      case TaskProgressEnum.inProgress:
        return Colors.orange;
      case TaskProgressEnum.done:
        return Colors.green;
      default:
        return Colors.white;
    }
  }

  IconData get icon {
    switch (this) {
      case TaskProgressEnum.toDo:
        return Icons.new_releases;
      case TaskProgressEnum.inProgress:
        return Icons.accessibility_new;
      case TaskProgressEnum.done:
        return Icons.check;
      default:
        return Icons.new_releases;
    }
  }

  static get mockRandom {
    final listForRandom = [
      TaskProgressEnum.expected,
      TaskProgressEnum.toDo,
      TaskProgressEnum.inProgress,
      TaskProgressEnum.done,
    ];
    final random = Random();
    final index = random.nextInt(listForRandom.length);
    return listForRandom[index];
  }
}

extension ListTaskProgressEnum on List<TaskProgressEnum> {
  List<String> get codes => map((e) => e.toCode()).toList();
}
