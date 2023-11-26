// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';
import 'package:task_management_module/src/domain/requests/put_status_task_body.dart';
import 'package:task_management_module/src/domain/services/task_service.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../shared/toast.dart';
import '../../widgets/gallery_picker.dart';

class CompleteTaskController extends GetxController {
  ///Params
  late final taskId = Get.arguments?['taskId'] as String?;

  ///States
  final Rxn<ImageEvidence> imageEvidence = Rxn<ImageEvidence>();

  ///Services
  final ITaskService _taskService = Get.find();

  Future<void> onPickImage() async {
    final result = await GalleryManager.pickSingleImage();
    if (result == null) {
      return;
    }
    if (result.file == null) {
      Logger.log('Pick image error: file is null',
          name: 'CompleteTaskController - onPickImage()');
      return;
    }
    imageEvidence.value = ImageEvidence(file: result.file!);
  }

  Future<void> onCompleteTask() async {
    try {
      if (taskId == null) {
        throw Exception('Task id is null');
      }
      if (imageEvidence.value == null) {
        Toast.showError(
          message: 'Vui lòng chọn ảnh chứng minh',
        );
        return;
      }

      final result = await Get.dialog<bool?>(
        AlertDialog(
          title: const Text('Xác nhận hoàn thành công việc'),
          content:
              const Text('Bạn có chắc chắn muốn hoàn thành công việc này?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(result: false);
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Get.back(result: true);
              },
              child: const Text('Đồng ý'),
            ),
          ],
        ),
      );
      if (result == null || !result) {
        return;
      }
      final uploadedFile = await _taskService.uploadFiles(
        [
          File(imageEvidence.value!.file.path),
        ],
      );
      if (uploadedFile.isEmpty) {
        throw Exception('Upload file error');
      }
      final success = await _taskService.putStatusTask(
        taskId!,
        PutStatusTaskBody(
          status: TaskProgressEnum.done.toCode(),
          imageEvidenceUrl: uploadedFile.first.link,
        ),
      );
      if (!success) {
        Toast.showError(
          message: 'Có lỗi xảy ra, vui lòng thử lại sau',
        );
        return;
      }
      Get.back(
          result: ReturnCompleteTask(
        isCompleteDone: true,
        imageEvidenceUrl: uploadedFile.first.link,
      ));
      Toast.showSuccess(
        message: 'Báo cáo công việc thành công',
      );
    } catch (e) {
      Logger.log(e.toString(),
          name: 'CompleteTaskController - onCompleteTask()');
      Toast.showError(
        message: 'Có lỗi xảy ra, vui lòng thử lại sau',
      );
    }
  }
}

class ReturnCompleteTask {
  final bool isCompleteDone;
  final String? imageEvidenceUrl;

  ReturnCompleteTask({
    required this.isCompleteDone,
    required this.imageEvidenceUrl,
  });
}

class ImageEvidence {
  final File file;

  ImageEvidence({
    required this.file,
  });
}
