import 'package:flutter/material.dart';

import '../../../core/utils/extensions/color_ext.dart';

class TaskEventReminderModel {
  final dynamic id;
  String content;
  final DateTime createdAt;
  final DateTime eventAt;
  final bool isNotify;

  final String colorCode;
  final Color color;

  ///Taskid
  final dynamic refId;

  final String eventId;

  TaskEventReminderModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.eventAt,
    required this.isNotify,
    required this.refId,
    required this.eventId,
    required this.colorCode,
  }) : color = ColorExt.fromHex(colorCode);

  factory TaskEventReminderModel.loading() {
    return TaskEventReminderModel(
      id: -1,
      content: 'Đang tải...',
      createdAt: DateTime.now(),
      eventAt: DateTime.now(),
      isNotify: false,
      refId: -1,
      eventId: '',
      colorCode: '0xff2196F3',
    );
  }

  factory TaskEventReminderModel.error() {
    return TaskEventReminderModel(
      id: -1,
      content: 'Không có dữ liệu',
      createdAt: DateTime.now(),
      eventAt: DateTime.now(),
      isNotify: false,
      refId: -1,
      eventId: '',
      colorCode: '0xff2196F3',
    );
  }

  static List<TaskEventReminderModel> loadings() => List.generate(
        3,
        (index) => TaskEventReminderModel.loading(),
      );

  static List<TaskEventReminderModel> errors() => List.generate(
        3,
        (index) => TaskEventReminderModel.error(),
      );
}
