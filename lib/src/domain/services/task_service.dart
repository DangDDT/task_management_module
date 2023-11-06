import 'dart:io';

import 'package:task_management_module/src/domain/models/task_model.dart';
import 'package:task_management_module/src/domain/models/task_progress_model.dart';
import 'package:task_management_module/src/domain/models/uploaded_file_model.dart';
import 'package:task_management_module/src/domain/requests/get_task_progress_param.dart';
import 'package:task_management_module/src/domain/requests/get_task_wedding_param.dart';
import 'package:task_management_module/src/domain/requests/put_status_task_body.dart';

abstract class ITaskService {
  Future<List<TaskProgressModel>> getTaskProgress(GetTaskProgressParam param);
  Future<List<TaskWeddingModel>> getTaskWeddings(GetTaskWeddingParam param);
  Future<TaskWeddingModel> getTaskWedding(String id);
  Future<List<UploadedFileModel>> uploadFiles(List<File> files);
  Future<bool> putStatusTask(String id, PutStatusTaskBody body);
}
