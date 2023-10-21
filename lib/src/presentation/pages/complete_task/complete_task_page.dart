import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/ui_constant.dart';
import 'complete_task_controller.dart';

class CompleteTaskPage extends GetView<CompleteTaskController> {
  const CompleteTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo công việc'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chọn hoặc chụp ảnh báo cáo công việc'),
            kGapH8,
            _ImageEvidenceBuilder(),
            Spacer(),
            _SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class _ImageEvidenceBuilder extends GetView<CompleteTaskController> {
  const _ImageEvidenceBuilder();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.imageEvidence.value != null) {
        return const _ImageEvidence();
      } else {
        return const _EmptyImageEvidence();
      }
    });
  }
}

class _ImageEvidence extends GetView<CompleteTaskController> {
  const _ImageEvidence();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Image.file(
              controller.imageEvidence.value!.file,
              fit: BoxFit.contain,
              width: double.infinity,
              height: 300,
            ),
          ),
          kGapH8,
          FilledButton.tonal(
            onPressed: controller.onPickImage,
            child: Text(
              'Chọn ảnh khác',
              style: kTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: kTheme.colorScheme.primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _EmptyImageEvidence extends GetView<CompleteTaskController> {
  const _EmptyImageEvidence();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.image_rounded,
            size: 100,
            color: Colors.blueGrey,
          ),
          const Text(
            'Hãy chọn hoặc chụp ảnh báo cáo công việc',
          ),
          kGapH8,
          FilledButton.tonal(
            onPressed: controller.onPickImage,
            child: Text(
              'Chọn ảnh',
              style: kTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: kTheme.colorScheme.primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _SubmitButton extends GetView<CompleteTaskController> {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: controller.onCompleteTask,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'Hoàn thành',
        style: kTheme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: kTheme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
