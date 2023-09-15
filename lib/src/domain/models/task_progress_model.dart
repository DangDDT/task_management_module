// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';

import 'statistic_model.dart';

class TaskProgressModel extends TaskWithStatusStatisticalModel {
  final dynamic id;
  final String name;
  final String description;
  final TaskProgressEnum type;
  TaskProgressModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required super.code,
    required super.value,
  });

  factory TaskProgressModel.loading() {
    return TaskProgressModel(
      id: -1,
      code: 'LOADING',
      name: 'Đang tải...',
      description: 'Đang tải...',
      type: TaskProgressEnum.all,
      value: 0,
    );
  }

  factory TaskProgressModel.error() {
    return TaskProgressModel(
      id: -1,
      code: 'ERROR',
      name: 'Đã xảy ra lỗi',
      description: 'Đã xảy ra lỗi',
      type: TaskProgressEnum.all,
      value: 0,
    );
  }

  factory TaskProgressModel.empty() {
    return TaskProgressModel(
      id: -1,
      code: 'EMPTY',
      name: 'Không có dữ liệu',
      description: 'Không có dữ liệu',
      type: TaskProgressEnum.all,
      value: 0,
    );
  }

  factory TaskProgressModel.all() {
    return TaskProgressModel(
      id: -1,
      code: 'ALL',
      name: 'Tất cả',
      description: 'Tất cả',
      type: TaskProgressEnum.all,
      value: 0,
    );
  }

  static List<TaskProgressModel> loadingList() {
    return [
      TaskProgressModel.loading(),
      TaskProgressModel.loading(),
      TaskProgressModel.loading(),
    ];
  }

  static List<TaskProgressModel> errorList() {
    return [
      TaskProgressModel.error(),
      TaskProgressModel.error(),
      TaskProgressModel.error(),
    ];
  }

  Color get color {
    switch (type) {
      case TaskProgressEnum.toDo:
        return Colors.grey;
      case TaskProgressEnum.inProgress:
        return Colors.blue;
      case TaskProgressEnum.done:
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  IconData get icon {
    switch (type) {
      case TaskProgressEnum.toDo:
        return Icons.new_releases;
      case TaskProgressEnum.inProgress:
        return Icons.pending_actions;
      case TaskProgressEnum.done:
        return Icons.done;
      default:
        return Icons.new_releases;
    }
  }
}
