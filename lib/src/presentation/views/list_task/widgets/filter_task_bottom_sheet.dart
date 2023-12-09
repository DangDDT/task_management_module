// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/presentation/shared/custom_chip.dart';

class FilterTask {
  final DateTime? duedate;
  FilterTask({
    this.duedate,
  });
}

class FilterTaskViewConfig {
  final bool isShowDueDate;
  const FilterTaskViewConfig({
    this.isShowDueDate = true,
  });
}

class FilterTaskBottomSheet extends StatelessWidget {
  final FilterTaskViewConfig config;
  final FilterTask? selectedFilterTask;
  const FilterTaskBottomSheet({
    super.key,
    this.selectedFilterTask,
    this.config = const FilterTaskViewConfig(),
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterTaskBottomSheetController>(
      init: FilterTaskBottomSheetController(
        selectedFilterTask: selectedFilterTask,
      ),
      builder: (_) {
        return Container(
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _Title(),
                  if (config.isShowDueDate) _DueDateSection(),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.tonal(
                  onPressed: _.onApplyFilterTask,
                  child: Text(
                    'Áp dụng',
                    style: kTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Title extends GetView<FilterTaskBottomSheetController> {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Lọc công việc',
          style: kTheme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: controller.onClearFilterTask,
          child: Text(
            'Bỏ chọn',
            style: kTheme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: kTheme.disabledColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _DueDateSection extends GetView<FilterTaskBottomSheetController> {
  _DueDateSection();

  final _config = Get.find<ModuleConfig>(tag: ModuleConfig.tag);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${_config.viewByRoleConfig?.filterDueDateTitle ?? 'Ngày hết hạn'}:',
          style: kTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: kTheme.disabledColor,
          ),
        ),
        Obx(
          () => CustomChip(
            title: controller.dueDate.value != null
                ? controller.dueDate.value!.toDateReadable()
                : 'Chọn ngày',
            onTap: controller.onDueDateChange,
          ),
        ),
      ],
    );
  }
}

class FilterTaskBottomSheetController extends GetxController {
  FilterTaskBottomSheetController({
    FilterTask? selectedFilterTask,
  }) : _filterTask = selectedFilterTask != null
            ? Rxn<FilterTask>(selectedFilterTask)
            : Rxn<FilterTask>();

  final Rxn<FilterTask> _filterTask;

  late final Rxn<DateTime> dueDate = Rxn<DateTime>(_filterTask.value?.duedate);

  Future<void> onDueDateChange() async {
    final pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: dueDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      dueDate.value = pickedDate;
    }
  }

  Future<void> onApplyFilterTask() async {
    Get.back(
      result: FilterTask(
        duedate: dueDate.value,
      ),
    );
  }

  Future<void> onClearFilterTask() async {
    dueDate.value = null;
  }
}
