// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

class TaskNoteModel {
  final dynamic id;
  String content;
  final DateTime createdAt;
  final dynamic refId;
  final String noteId;
  TaskNoteModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.refId,
    required this.noteId,
  });

  factory TaskNoteModel.loading() {
    return TaskNoteModel(
      id: -1,
      content: 'Đang tải...',
      createdAt: DateTime.now(),
      refId: -1,
      noteId: const Uuid().v4(),
    );
  }

  factory TaskNoteModel.error() {
    return TaskNoteModel(
      id: -1,
      content: 'Không có dữ liệu',
      createdAt: DateTime.now(),
      refId: -1,
      noteId: const Uuid().v4(),
    );
  }

  static List<TaskNoteModel> loadings() => List.generate(
        3,
        (index) => TaskNoteModel.loading(),
      );

  static List<TaskNoteModel> errors() => List.generate(
        3,
        (index) => TaskNoteModel.error(),
      );
}
