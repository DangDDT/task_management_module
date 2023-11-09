import 'dart:io';

import 'package:get/get.dart';
import 'package:task_management_module/src/domain/domain.dart';
import 'package:task_management_module/src/domain/models/task_model.dart';
import 'package:task_management_module/src/domain/models/task_progress_model.dart';
import 'package:task_management_module/src/domain/models/uploaded_file_model.dart';
import 'package:task_management_module/src/domain/requests/get_task_progress_param.dart';
import 'package:task_management_module/src/domain/requests/put_status_task_body.dart';
import 'package:task_management_module/src/domain/services/task_service.dart';
import 'package:wss_repository/entities/task.dart';
import 'package:wss_repository/entities/task_count.dart';
import 'package:wss_repository/entities/uploaded_file.dart';
import 'package:wss_repository/repositories/file_repository.dart';
import 'package:wss_repository/wss_repository.dart';

import '../../domain/requests/get_task_wedding_param.dart';

class TaskService extends ITaskService {
  final IStatisticRepository _statisticRepository = Get.find();
  final ITaskRepository _taskRepository = Get.find();
  final IFileRepository _fileRepository = Get.find();
  final Mapper _mapper = Mapper.instance;

  @override
  Future<List<TaskProgressModel>> getTaskProgress(
    GetTaskProgressParam param,
  ) async {
    final result = await _statisticRepository.getStatisticTaskCount(
      param: GetStatisticTaskCountParam(
        fromDate: param.fromDate,
        toDate: param.toDate,
      ),
    );
    return _mapper.mapListData<TaskCount, TaskProgressModel>(result);
  }

  @override
  Future<List<TaskWeddingModel>> getTaskWeddings(
    GetTaskWeddingParam param,
  ) async {
    final result = await _taskRepository.getTasks(
      param: GetTaskParam(
        page: param.pageIndex,
        pageSize: param.pageSize,
        sortKey: param.orderBy,
        sortOrder: param.orderType,
        dueDateFrom: param.dueDateFrom,
        dueDateTo: param.dueDateTo,
        status: param.status,
        taskName: param.taskName,
      ),
    );
    if (result.data == null || (result.data?.isEmpty ?? true)) {
      return [];
    }
    return _mapper.mapListData<Task, TaskWeddingModel>(result.data!);
  }

  @override
  Future<TaskWeddingModel> getTaskWedding(String id) async {
    final result = await _taskRepository.getTask(id: id);
    return _mapper.mapData<Task, TaskWeddingModel>(result);
  }

  @override
  Future<List<UploadedFileModel>> uploadFiles(List<File> files) async {
    final result = await _fileRepository.uploadFiles(files);
    return _mapper.mapListData<UploadedFile, UploadedFileModel>(result);
  }

  @override
  Future<bool> putStatusTask(String id, PutStatusTaskBody body) {
    final result = _taskRepository.putTask(
      id: id,
      body: PutTaskBody(
        status: body.status,
        imageEvidence: body.imageEvidenceUrl,
      ),
    );
    return result;
  }
}
