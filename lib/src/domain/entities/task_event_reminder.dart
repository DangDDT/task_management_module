// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'task_event_reminder.g.dart';

@collection
class TaskEventReminder {
  final Id id = Isar.autoIncrement;
  String content;
  final DateTime createdAt;
  final DateTime eventAt;
  final bool isNotify;
  final String colorCode;
  final String taskId;
  final String userId;

  final String eventId;
  TaskEventReminder({
    required this.content,
    required this.eventAt,
    required this.isNotify,
    required this.taskId,
    this.colorCode = '0xff2196F3',
    required this.eventId,
    required this.userId,
  }) : createdAt = DateTime.now();

  TaskEventReminder.update({
    required this.content,
    required this.eventAt,
    required this.isNotify,
    required this.taskId,
    required this.colorCode,
    required this.eventId,
    required this.createdAt,
    required this.userId,
  });
}
