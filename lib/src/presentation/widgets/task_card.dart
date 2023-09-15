// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/core.dart';
import '../shared/custom_chip.dart';

class TaskServiceCardViewConfig {
  final bool isShowDescription;
  final bool isShowDueDate;
  final bool isShowTag;
  final bool isFilled;
  final bool isShowFullName;
  final bool isShowFullDescription;
  const TaskServiceCardViewConfig({
    this.isShowDescription = true,
    this.isShowDueDate = true,
    this.isShowTag = true,
    this.isFilled = true,
    this.isShowFullName = false,
    this.isShowFullDescription = false,
  });
}

class TaskServiceCard extends StatelessWidget {
  const TaskServiceCard({
    super.key,
    this.onTap,
    required this.taskId,
    required this.name,
    required this.description,
    required this.duedate,
    required this.taskMasterName,
    required this.serviceName,
    this.config = const TaskServiceCardViewConfig(),
  });

  final VoidCallback? onTap;
  final dynamic taskId;
  final String name;
  final String description;
  final DateTime duedate;
  final String taskMasterName;
  final String serviceName;
  final TaskServiceCardViewConfig config;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 0,
          color: config.isFilled
              ? kTheme.colorScheme.primaryContainer.withOpacity(0.4)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: kTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: config.isFilled
                        ? kTheme.colorScheme.onBackground
                        : kTheme.colorScheme.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (config.isShowTag) ...[
                  kGapH8,
                  Row(
                    children: [
                      CustomChip(
                        icon: Icon(
                          FontAwesomeIcons.diamond,
                          size: 12.0,
                          color: kTheme.colorScheme.primary.withOpacity(0.8),
                        ),
                        title: serviceName,
                        color: kTheme.colorScheme.surfaceTint,
                        textStyle: kTheme.textTheme.bodySmall?.copyWith(
                          color: kTheme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                      ),
                      kGapW4,
                      CustomChip(
                        icon: Icon(
                          FontAwesomeIcons.userTie,
                          size: 12.0,
                          color: kTheme.colorScheme.primary.withOpacity(0.8),
                        ),
                        title: taskMasterName,
                        color: kTheme.colorScheme.surfaceTint,
                        textStyle: kTheme.textTheme.bodySmall?.copyWith(
                          color: kTheme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                      ),
                    ],
                  ),
                ],
                if (config.isShowDescription) ...[
                  kGapH8,
                  Text(
                    description,
                    style: kTheme.textTheme.bodyMedium,
                    maxLines: config.isShowFullDescription ? null : 2,
                    overflow: config.isShowFullDescription
                        ? null
                        : TextOverflow.ellipsis,
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
                              text: 'Hạn chót ',
                              style: kTheme.textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: duedate.toReadable(),
                              style: kTheme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '(${duedate.toReadableDueDateWithHourString()})',
                        style: kTheme.textTheme.bodySmall?.copyWith(
                          color: kTheme.colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
