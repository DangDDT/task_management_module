import '../entities/task_note.dart';
import '../models/task_note.dart';

abstract class LocalNoteService {
  Future<List<TaskNoteModel>> getNoteByRefId(
    String refId,
    String userId,
  );

  Future<TaskNoteModel?> getNoteById(
    String noteId,
  );

  Future<TaskNoteModel?> addNewTaskNote({
    required TaskNote taskNote,
  });

  Future<bool> deleteTaskNoteById(
    String noteId,
  );

  Future<TaskNoteModel?> updateTaskNoteById({
    required TaskNote taskNote,
  });
}
