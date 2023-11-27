import 'package:core_picker/core/utils/helpers/toast.dart';
import 'package:get/get.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/models/task_event_reminder.dart';
import 'package:task_management_module/src/domain/models/task_model.dart';
import 'package:task_management_module/src/domain/models/task_order_detail.dart';
import 'package:task_management_module/src/domain/services/local_note_service.dart';
import 'package:task_management_module/src/domain/services/local_task_event_reminder_service.dart';
import 'package:task_management_module/src/domain/services/task_service.dart';
import 'package:task_management_module/src/presentation/view_models/state_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../../domain/entities/task_note.dart';
import '../../../domain/models/task_note.dart';
import 'order_detail_dialog.dart';
import 'widgets/add_note_dialog.dart';

class TaskDetailViewController extends GetxController {
  TaskDetailViewController({required this.id});

  ///Config
  final ModuleConfig config = Get.find(tag: ModuleConfig.tag);

  ///Services
  final LocalNoteService _localNoteService = Get.find();
  final LocalTaskEventReminderService _localTaskEventReminderService =
      Get.find();
  final ITaskService _taskService = Get.find();

  final dynamic id;

  ///States
  final StateModel<TaskWeddingModel> taskModel = StateModel(
    data: Rx(TaskWeddingModel.loading()),
  );
  final StateModel<List<TaskNoteModel>> notes = StateModel(
    data: Rx(TaskNoteModel.loadings()),
  );

  final StateModel<List<TaskEventReminderModel>> events = StateModel(
    data: Rx(TaskEventReminderModel.loadings()),
  );

  final RxBool isShowAllNote = false.obs;

  @override
  onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.wait([
      loadTaskDetailModel(),
      loadTaskNoteModel(),
      loadTaskEventReminderModel(),
    ]);
  }

  Future<void> loadTaskDetailModel() async {
    taskModel.loading(loadingData: TaskWeddingModel.loading());
    try {
      final data = await _taskService.getTaskWedding(id.toString());

      ///Sort comments by createdAt DESC
      data.comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      taskModel.success(data);
    } catch (e, stackTrace) {
      Logger.log(e.toString(),
          name: 'TaskDetailViewController_loadTaskDetailModel()',
          stackTrace: stackTrace);
      taskModel.error(
        e.toString(),
        errorData: TaskWeddingModel.error(),
      );
    }
  }

  Future<void> loadTaskNoteModel() async {
    notes.loading(loadingData: TaskNoteModel.loadings());
    try {
      final data = await _localNoteService.getNoteByRefId(
        id.toString(),
        config.userConfig.userId,
      );
      if (data.isEmpty) {
        notes.empty(emptyData: List<TaskNoteModel>.empty());
        return;
      }
      data.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notes.success(data);
    } catch (e) {
      notes.error(
        e.toString(),
        errorData: TaskNoteModel.errors(),
      );
    }
  }

  Future<void> loadTaskEventReminderModel() async {
    events.loading(loadingData: TaskEventReminderModel.loadings());
    try {
      final data = await _localTaskEventReminderService.getTaskEventReminders(
        DateTime.now(),
        userId: config.userConfig.userId,
        taskId: id.toString(),
      );
      if (data.isEmpty) {
        events.empty(emptyData: List<TaskEventReminderModel>.empty());
        return;
      }
      data.sort((a, b) => b.eventAt.compareTo(a.eventAt));
      events.success(data);
    } catch (e) {
      events.error(
        e.toString(),
        errorData: TaskEventReminderModel.errors(),
      );
    }
  }

  Future<void> addNote() async {
    final content = await Get.dialog(
      const AddEditNoteDialog(
        title: 'Thêm ghi chú',
      ),
    );
    try {
      if (content == null) return;
      final added = await _localNoteService.addNewTaskNote(
          taskNote: TaskNote(
        userId: config.userConfig.userId,
        noteId:
            '${config.userConfig.userId}_${id.toString()}_${DateTime.now().toIso8601String()}',
        refId: id.toString(),
        content: content,
      ));
      if (added == null) {
        throw Exception('Có lỗi xảy ra, vui lòng thử lại sau');
      }
      notes.success([
        TaskNoteModel(
          id: added.id,
          content: added.content,
          createdAt: added.createdAt,
          refId: added.refId,
          noteId: added.noteId,
        ),
        ...notes.data.value,
      ]);
    } catch (e, stackTrace) {
      Logger.log(e.toString(),
          name: 'TaskDetailViewController_addNote()', stackTrace: stackTrace);
      Toast.error(
        message: 'Có lỗi xảy ra, vui lòng thử lại sau',
      );
    }
  }

  Future<void> deleteNote(TaskNoteModel item) async {
    try {
      final success = await _localNoteService.deleteTaskNoteById(item.noteId);
      if (!success) {
        throw Exception('Có lỗi xảy ra, vui lòng thử lại sau');
      }
      notes.success([...notes.data.value..remove(item)]);
      if (notes.data.value.isEmpty) {
        notes.empty(emptyData: List<TaskNoteModel>.empty());
      }
    } catch (e, stackTrace) {
      Logger.log(e.toString(),
          name: 'TaskDetailViewController_deleteNote()',
          stackTrace: stackTrace);
      Toast.error(
        message: 'Có lỗi xảy ra, vui lòng thử lại sau',
      );
    }
  }

  Future<void> updateNote(TaskNoteModel item) async {
    try {
      final content = await Get.dialog<String?>(
        AddEditNoteDialog(
          initialContent: item.content,
          title: 'Sửa ghi chú',
        ),
      );
      if (content == item.content) return;
      if (content == null) return;
      if (content.isEmpty) {
        await deleteNote(
          item,
        );
        return;
      }
      final updated = await _localNoteService.updateTaskNoteById(
        taskNote: TaskNote.update(
          userId: config.userConfig.userId,
          noteId: item.noteId,
          content: content,
          createdAt: item.createdAt,
          refId: item.refId,
        ),
      );
      if (updated == null) {
        throw Exception('Có lỗi xảy ra, vui lòng thử lại sau');
      }
      final oldItem = notes.data.value
          .firstOrDefault((item) => item.noteId == updated.noteId);
      if (oldItem == null) {
        throw Exception('Có lỗi xảy ra, vui lòng thử lại sau');
      }
      oldItem.content = updated.content;
      notes.success([...notes.data.value]);
    } catch (e, stackTrace) {
      Logger.log(
        e.toString(),
        name: 'TaskDetailViewController_updateNote()',
        stackTrace: stackTrace,
      );
      Toast.error(
        message: 'Có lỗi xảy ra, vui lòng thử lại sau',
      );
    }
  }

  Future<void> onTapOrderDetailCard(TaskOrderDetailModel orderDetail) async {
    await Get.dialog(
      OrderDetailDialog(orderDetail: orderDetail),
    );
  }

  Future<void> call(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(phoneLaunchUri);
  }

  Future<void> sendEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(emailLaunchUri);
  }

  Future<void> sendSms(String phoneNumber) async {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(smsLaunchUri);
  }

  Future<void> goToTaskReminder() async {
    if (!taskModel.state.value.isSuccess) {
      return;
    }
    await Get.toNamed(
      RouteConstants.taskReminderRoute,
      arguments: {
        'taskModel': taskModel.data.value,
      },
    );
    await loadTaskEventReminderModel();
  }

  Future<void> onRefreshComments() async {
    try {
      final data = await _taskService.getTaskWedding(
        id.toString(),
      );
      data.comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      taskModel.data.value = taskModel.data.value.copyWithComment(
        data.comments,
      );
    } catch (e) {
      Logger.log(e.toString(),
          name: 'TaskDetailViewController_onRefreshComments()');
      Toast.error(
        message: 'Có lỗi xảy ra, vui lòng thử lại sau',
      );
    }
  }

  Future<void> onAddComment(String comment) async {
    try {
      final addComment = await _taskService.addComment(
        id.toString(),
        comment,
      );
      if (!addComment) {
        throw Exception('Có lỗi xảy ra, vui lòng thử lại sau');
      }
      final data = await _taskService.getTaskWedding(
        id.toString(),
      );
      data.comments.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      taskModel.data.value = taskModel.data.value.copyWithComment(
        data.comments,
      );
    } catch (e) {
      Logger.log(e.toString(), name: 'TaskDetailViewController_onAddComment()');
      Toast.error(
        message: 'Có lỗi xảy ra, vui lòng thử lại sau',
      );
    }
  }
}
