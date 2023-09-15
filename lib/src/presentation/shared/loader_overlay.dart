import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoaderOverlay {
  static void show() {
    final context = Get.context!;
    showGeneralDialog(
      barrierDismissible: false,
      context: context,
      useRootNavigator: true,
      pageBuilder: (context, _, __) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  static void hide() {
    Get.back();
  }
}
