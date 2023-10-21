import 'package:task_management_module/src/domain/models/task_note.dart';

import '../../domain.dart';
import '../../entities/task_note.dart';

class TaskNoteMapper extends BaseDataMapperProfile<TaskNote, TaskNoteModel> {
  @override
  TaskNoteModel mapData(TaskNote entity, Mapper mapper) {
    return TaskNoteModel(
      content: entity.content,
      createdAt: entity.createdAt,
      refId: entity.refId,
      id: entity.id,
      noteId: entity.noteId,
    );
  }
}
