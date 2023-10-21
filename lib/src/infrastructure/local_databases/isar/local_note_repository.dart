// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:isar/isar.dart';
import 'package:task_management_module/src/domain/entities/task_note.dart';
import 'package:task_management_module/src/domain/services/local_note_service.dart';
import 'package:task_management_module/src/infrastructure/local_databases/isar/isar_database.dart';

import '../../../domain/domain.dart';
import '../../../domain/models/task_note.dart';

class LocalNoteRepository extends LocalNoteService {
  final IsarDatabase _isar = IsarDatabase.instance;
  final Mapper _mapper = Mapper.instance;

  @override
  Future<TaskNoteModel?> addNewTaskNote({required TaskNote taskNote}) async {
    try {
      final id = _isar.database.writeTxnSync<int>(() {
        final id = _isar.database.taskNotes.putSync(
          taskNote,
        );
        return id;
      });
      final result = _isar.database.taskNotes.getSync(id);
      if (result == null) {
        return null;
      }
      return _mapper.mapData<TaskNote, TaskNoteModel>(
        result,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteTaskNoteById(String noteId) async {
    try {
      final success = _isar.database.writeTxnSync(() {
        final success = _isar.database.taskNotes
            .where()
            .filter()
            .noteIdEqualTo(noteId)
            .deleteFirstSync();
        return success;
      });
      return success;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TaskNoteModel>> getNoteByRefId(
      String refId, String userId) async {
    try {
      final result = _isar.database.taskNotes
          .filter()
          .refIdEqualTo(refId)
          .userIdEqualTo(userId)
          .findAllSync();
      return _mapper.mapListDataOrDefault<TaskNote, TaskNoteModel>(
            result,
          ) ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TaskNoteModel?> updateTaskNoteById(
      {required TaskNote taskNote}) async {
    try {
      final task =
          _isar.database.taskNotes.filter().noteIdEqualTo(taskNote.noteId);
      final taskFind = task.findFirstSync();
      if (taskFind == null) {
        return null;
      }
      final updated = _isar.database.writeTxnSync(() {
        final deleted = task.deleteFirstSync();
        if (!deleted) {
          return null;
        }
        final id = _isar.database.taskNotes.putSync(
          taskNote,
        );
        return id;
      });
      if (updated == null) {
        return null;
      }
      final result = await _isar.database.taskNotes.get(updated);
      if (result == null) {
        return null;
      }
      return _mapper.mapData<TaskNote, TaskNoteModel>(
        result,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TaskNoteModel?> getNoteById(String noteId) async {
    try {
      final result = _isar.database.taskNotes
          .filter()
          .noteIdEqualTo(noteId)
          .findFirstSync();
      if (result == null) {
        return null;
      }
      return _mapper.mapData<TaskNote, TaskNoteModel>(
        result,
      );
    } catch (e) {
      rethrow;
    }
  }
}
