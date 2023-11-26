// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';

import '../../../core/core.dart';
import '../../domain/models/task_model.dart';
import '../shared/custom_chip.dart';

class TaskServiceCardViewConfig {
  final bool isShowDescription;
  final bool isShowDueDate;
  final bool isShowTag;
  final bool isFilled;
  final bool isShowFullName;
  final bool isShowFullDescription;
  final bool isShowCustomerName;
  final bool isShowServiceName;
  final bool isShowCountDown;
  final ActionConfig? actionConfig;
  final bool isShowStatus;
  final TextStyle? taskNameStyle;
  final Color? taskCardColor;
  final bool isShowExpiredTag;
  const TaskServiceCardViewConfig({
    this.isShowDescription = true,
    this.isShowDueDate = true,
    this.isShowTag = true,
    this.isFilled = true,
    this.isShowFullName = false,
    this.isShowCustomerName = false,
    this.isShowFullDescription = false,
    this.actionConfig,
    this.isShowCountDown = true,
    this.isShowStatus = false,
    this.isShowServiceName = false,
    this.taskNameStyle,
    this.taskCardColor,
    this.isShowExpiredTag = false,
  });
}

class ActionConfig {
  final List<ActionItem> actions;
  ActionConfig({
    required this.actions,
  });
}

class TaskWeddingCard extends StatelessWidget {
  const TaskWeddingCard({
    super.key,
    this.onTap,
    required this.taskId,
    required this.name,
    required this.description,
    required this.duedate,
    required this.taskMasterName,
    required this.customerName,
    required this.serviceNames,
    required this.status,
    this.config = const TaskServiceCardViewConfig(),
  }) : item = null;

  TaskWeddingCard.item({
    super.key,
    required this.item,
    this.config = const TaskServiceCardViewConfig(),
  })  : onTap = null,
        taskId = item?.id,
        name = item?.name ?? '',
        description = item?.description ?? '',
        duedate = item?.duedate ?? DateTime.now(),
        customerName = item?.customer.fullName ?? '',
        taskMasterName = item?.taskMaster?.name ?? '',
        serviceNames =
            item?.orderDetail != null && item?.orderDetail.service != null
                ? [item?.orderDetail].map((e) => e!.service.name).toList()
                : <String>[],
        status = item?.status ?? TaskProgressEnum.toDo;

  final TaskWeddingModel? item;
  final VoidCallback? onTap;
  final dynamic taskId;
  final String name;
  final String description;
  final DateTime duedate;
  final String taskMasterName;
  final String customerName;
  final List<String> serviceNames;
  final TaskProgressEnum status;
  final TaskServiceCardViewConfig config;

  Future<void> showActionDialog() async {
    await Get.bottomSheet(
      Container(
        height: (config.actionConfig?.actions.length.toDouble() ?? 1) * 56.0,
        decoration: BoxDecoration(
          color: kTheme.colorScheme.background,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...config.actionConfig?.actions.map((e) => ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: kTheme.colorScheme.primary.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          e.icon,
                          color: kTheme.colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        e.actionLabel,
                        style: kTheme.textTheme.titleMedium,
                      ),
                      onTap: () async {
                        Get.back();
                        await e.onTap.call();
                      },
                    )) ??
                [],
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: config.taskCardColor ??
                (config.isFilled
                    ? kTheme.colorScheme.primaryContainer.withOpacity(0.4)
                    : kTheme.colorScheme.background),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: kTheme.colorScheme.background),
          ),
          child: Padding(
            padding: config.isFilled
                ? const EdgeInsets.all(16.0)
                : const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: config.taskNameStyle ??
                          kTheme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: config.isFilled
                                ? kTheme.colorScheme.onBackground
                                : kTheme.colorScheme.primary,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (config.actionConfig != null) ...[
                    kGapW8,
                    GestureDetector(
                      onTap: showActionDialog,
                      child: Icon(
                        Icons.more_horiz,
                        color: kTheme.colorScheme.primary,
                      ),
                    ),
                  ],
                ],
              ),
              if (config.isShowStatus) ...[
                kGapH8,
                Row(
                  children: [
                    CustomChip(
                      icon: Icon(status.icon, size: 16.0, color: status.color),
                      title: status.name,
                      color: status.color,
                      textStyle: kTheme.textTheme.bodySmall?.copyWith(
                        color: kTheme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                    ),
                    if (config.isShowExpiredTag &&
                        duedate.lastTimeOfDate().isBefore(
                              DateTime.now(),
                            ) &&
                        (!status.isDone && !status.isExpected)) ...[
                      kGapW4,
                      CustomChip(
                        icon: const Icon(
                          Icons.warning_amber_rounded,
                          size: 16.0,
                          color: Colors.red,
                        ),
                        title: 'Quá hạn hoàn thành',
                        color: Colors.red,
                        textStyle: kTheme.textTheme.bodySmall?.copyWith(
                          color: kTheme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                      ),
                    ]
                  ],
                ),
              ],
              if (config.isShowDescription) ...[
                kGapH8,
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Mô tả: ',
                        style: kTheme.textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: description,
                        style: kTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (config.isShowFullName && taskMasterName.isNotNullOrEmpty) ...[
                kGapH4,
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Người tạo công việc: ',
                        style: kTheme.textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: taskMasterName,
                        style: kTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                kGapH8,
              ] else
                kGapH8,
              if (config.isShowCustomerName) ...[
                kGapH4,
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Khách hàng: ',
                        style: kTheme.textTheme.bodySmall,
                      ),
                      TextSpan(
                        text: customerName,
                        style: kTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (config.isShowServiceName) ...[
                Wrap(
                  runSpacing: 4.0,
                  spacing: 4.0,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...serviceNames
                        .take(2)
                        .map(
                          (name) => CustomChip(
                            constraints: BoxConstraints(
                              maxWidth: serviceNames.length > 2
                                  ? context.width * 0.3
                                  : context.width * 0.5,
                            ),
                            title: name,
                            fillColor: true,
                            color: kTheme.colorScheme.primary,
                            textStyle: kTheme.textTheme.bodySmall?.copyWith(
                              color: kTheme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                          ),
                        )
                        .toList(),
                    if (serviceNames.length > 2) ...[
                      kGapW4,
                      CustomChip(
                        title: '+${serviceNames.length - 2} dịch vụ',
                        color: kTheme.colorScheme.primary.withOpacity(0.2),
                        textStyle: kTheme.textTheme.bodySmall?.copyWith(
                          color: kTheme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                      ),
                    ]
                  ],
                ),
              ],
              if (config.isShowDueDate) ...[
                kGapH12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Ngày khách cần: ',
                            style: kTheme.textTheme.bodySmall,
                          ),
                          TextSpan(
                            text: duedate.toFullString(),
                            style: kTheme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (config.isShowCountDown) ...[
                      kGapW4,
                      Text(
                        '(${duedate.toReadableDueDateWithHourString()})',
                        style: kTheme.textTheme.bodySmall?.copyWith(
                          color: kTheme.colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ] else
                const SizedBox.shrink(),
            ]),
          ),
        ),
      ),
    );
  }
}

class ActionItem {
  final IconData icon;
  final String actionLabel;
  final Function() onTap;
  ActionItem({
    required this.icon,
    required this.actionLabel,
    required this.onTap,
  });
}
