import 'package:core_picker/core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GalleryManager {
  static Future<AttachmentResult?> showGallery() async {
    final result = await CorePicker.showPickerMenu(
      isShowLog: kDebugMode,
      submitButtonIcon: Icons.send,
      submitButtonTitle: 'Gửi',
      attachmentTypes: [
        AttachmentType.media,
        AttachmentType.file,
        AttachmentType.location,
      ],
      filePickerOption: const FilePickerOption(
        isUseCaptionField: false,
        filePickerTypes: [
          FilePickerType.media,
          FilePickerType.custom,
        ],
      ),
      mediaPickerOption: MediaPickerOption(
        isUseCaptionField: false,
        maxMediaPerLoadTime: 15,
      ),
      locationPickerOption: const LocationPickerOption(
        isUseCaptionField: false,
      ),
    );
    return result;
  }

  ///Pick single image from gallery / camera
  static Future<MediaAttachmentData?> pickSingleImage() async {
    final result = await CorePicker.showPickerMenu(
      attachmentTypes: [
        AttachmentType.media,
      ],
      isShowLog: true,
      mediaPickerOption: MediaPickerOption(
        isUseCaptionField: false,
        mediaPickerTypes: [
          MediaPickerType.image,
        ],
        isMultiSelection: false,
      ),
    );
    return (result?.data.first as MediaAttachmentData?);
  }

  static Future<CameraReturnValue?> goCamera() async {
    final result = await CorePicker.goCamera(
      cameraModes: [CameraMode.photo],
      logger: kDebugMode,
    );
    return result;
  }
}

typedef CameraReturnValue = PreviewReturnValue;
