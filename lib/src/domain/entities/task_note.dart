import 'package:isar/isar.dart';

part 'task_note.g.dart';

@collection
class TaskNote {
  final Id id = Isar.autoIncrement;
  @Name("noteId")
  final String noteId;
  String content;
  final DateTime createdAt;
  final String refId;
  final String userId;

  TaskNote({
    required this.content,
    required this.refId,
    required this.noteId,
    required this.userId,
  }) : createdAt = DateTime.now();

  TaskNote.update({
    required this.noteId,
    required this.content,
    required this.refId,
    required this.createdAt,
    required this.userId,
  });
}
