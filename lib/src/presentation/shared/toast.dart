import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

class Toast {
  static const Duration _duration = Duration(seconds: 2);
  static void showSuccess({
    String message = 'Thành công',
    String title = 'Thông báo',
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: kTheme.colorScheme.primary,
      colorText: Colors.white,
      duration: _duration,
    );
  }

  static void showError({
    String message = 'Đã có lỗi xảy ra',
    String title = 'Thông báo',
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: _duration,
    );
  }

  static void showInfo({
    String message = 'Thông tin',
    String title = 'Thông báo',
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      duration: _duration,
    );
  }
}
