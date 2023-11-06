import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_module/core/constants/ui_constant.dart';
import 'package:task_management_module/src/domain/enums/private/loading_enum.dart';
import 'package:task_management_module/src/presentation/views/task_reminder/task_reminder_view.dart';

import 'dashboard_task_reminder_controller.dart';

class DashboardTaskReminderView extends StatelessWidget {
  final DashboardTaskReminderController? controller;
  const DashboardTaskReminderView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardTaskReminderController>(
      init: controller ?? Get.put(DashboardTaskReminderController()),
      builder: (DashboardTaskReminderController controller) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lịch nhắc việc hôm nay',
                style: kTheme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Obx(
                () {
                  switch (controller.events.state.value) {
                    case LoadingState.initial:
                    case LoadingState.loading:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case LoadingState.success:
                      return TaskReminderView.horizontalListCard(
                        data: controller.events.data.value,
                        onTap: (item, index) => {},
                      );
                    case LoadingState.error:
                      return const Center(
                        child: Text('Có lỗi xảy ra'),
                      );
                    case LoadingState.empty:
                      return Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.notifications_off,
                              size: 48,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Không có việc cần nhắc nhở',
                              style: kTheme.textTheme.titleMedium?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
