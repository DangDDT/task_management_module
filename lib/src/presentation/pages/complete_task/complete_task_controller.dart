// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:get/get.dart';

import '../../../../core/utils/helpers/logger.dart';
import '../../shared/toast.dart';
import '../../widgets/gallery_picker.dart';

class CompleteTaskController extends GetxController {
  ///States
  final Rxn<ImageEvidence> imageEvidence = Rxn<ImageEvidence>();

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
    if (imageEvidence.value == null) {
      Toast.showError(
        message: 'Vui lòng chọn ảnh chứng minh',
      );
      return;
    }

    ///TODO: Call API
    Get.back(result: true);
    Toast.showSuccess(
      message: 'Báo cáo công việc thành công',
    );
  }
}

class ImageEvidence {
  final File file;

  ImageEvidence({
    required this.file,
  });
}
