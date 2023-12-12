import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/presentation/views/task_reminder/task_reminder_view.dart';

import '../../../domain/domain.dart';
import 'task_reminder_controller.dart';

class TaskReminderPage extends GetView<TaskReminderController> {
  const TaskReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhắc nhở công việc'),
      ),
      body: GetBuilder<TaskReminderController>(
        init: TaskReminderController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // TaskWeddingCard(
                //   taskId: controller.taskModel.id,
                //   name: controller.taskModel.name,
                //   description: controller.taskModel.description,
                //   duedate: controller.taskModel.duedate,
                //   taskMasterName: controller.taskModel.taskMaster.name,
                //   serviceName: controller.taskModel.orderDetail.service.name,
                //   status: controller.taskModel.status,
                //   config: const TaskServiceCardViewConfig(
                //     isShowDescription: true,
                //     isShowDueDate: false,
                //     isShowFullDescription: true,
                //     isShowFullName: true,
                //     isShowServiceName: true,
                //     isShowStatus: true,
                //     isShowTag: true,
                //   ),
                // ),
                // kGapH8,
                const _CalendarWidget(),
                Divider(
                  height: 32,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: kTheme.disabledColor.withOpacity(0.1),
                ),
                const _EventBuilder(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CalendarWidget extends GetView<TaskReminderController> {
  const _CalendarWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final startDate = controller.taskModel.createdDate.firstTimeOfDate();
        final endDate = controller.taskModel.duedate.lastTimeOfDate();
        return TableCalendar(
          daysOfWeekHeight: 48,
          firstDay: controller.taskModel.createdDate.firstTimeOfDate(),
          lastDay: controller.taskModel.duedate.lastTimeOfDate(),
          focusedDay: controller.selectedDate.value,
          currentDay: DateTime.now(),
          rangeStartDay: startDate.floorDate,
          rangeEndDay: endDate,
          enabledDayPredicate: (day) {
            return day.isBetween(
              startDate.firstTimeOfDate(),
              endDate.lastTimeOfDate(),
            );
          },
          headerVisible: true,
          formatAnimationCurve: Curves.easeInOut,
          formatAnimationDuration: const Duration(milliseconds: 300),
          calendarFormat: endDate.difference(startDate).inDays > 14
              ? CalendarFormat.month
              : CalendarFormat.twoWeeks,
          daysOfWeekVisible: true,
          onDaySelected: (selectedDate, _) {
            if (!selectedDate.isBetween(
                startDate.firstTimeOfDate(), endDate.lastTimeOfDate())) {
              return;
            }
            controller.onDaySelected(selectedDate);
          },
          selectedDayPredicate: (day) {
            return controller.selectedDate.value == day;
          },
          calendarBuilders: CalendarBuilders(
            todayBuilder: (context, date, _) {
              return Container(
                margin: const EdgeInsets.all(8),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: Text(
                  date.day.toString(),
                  style: kTheme.textTheme.titleMedium?.copyWith(
                    color: kTheme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            rangeHighlightBuilder: (context, date, _) {
              if (date.isBetween(
                startDate.firstTimeOfDate(),
                DateTime.now().lastTimeOfDate(),
              )) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  child: Text(
                    date.day.toString(),
                    style: kTheme.textTheme.bodyMedium?.copyWith(
                      color: kTheme.colorScheme.onError,
                    ),
                  ),
                );
              } else if (date.isBetween(
                  DateTime.now().firstTimeOfDate(), endDate.lastTimeOfDate())) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kTheme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    date.day.toString(),
                    style: kTheme.textTheme.bodyMedium?.copyWith(
                      color: kTheme.colorScheme.onError,
                    ),
                  ),
                );
              }
              return null;
            },
            rangeEndBuilder: (context, date, _) {
              return Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kTheme.colorScheme.error,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  date.day.toString(),
                  style: kTheme.textTheme.bodyMedium?.copyWith(
                    color: kTheme.colorScheme.onError,
                  ),
                ),
              );
            },
            rangeStartBuilder: (context, date, _) {
              return Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kTheme.disabledColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  date.day.toString(),
                  style: kTheme.textTheme.bodyMedium?.copyWith(
                    color: kTheme.colorScheme.onError,
                  ),
                ),
              );
            },
            selectedBuilder: (context, date, _) {
              return Container(
                margin: const EdgeInsets.all(4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kTheme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  date.day.toString(),
                  style: kTheme.textTheme.titleMedium?.copyWith(
                    color: kTheme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            weekendTextStyle: kTheme.textTheme.bodyMedium!.copyWith(
              color: kTheme.colorScheme.error,
            ),
            holidayTextStyle: kTheme.textTheme.bodyMedium!.copyWith(
              color: kTheme.colorScheme.error,
            ),
          ),
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          locale: "vi_VN",
        );
      },
    );
  }
}

class _EventBuilder extends GetView<TaskReminderController> {
  const _EventBuilder();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      FontAwesomeIcons.calendar,
                      color: kTheme.colorScheme.primary,
                      size: 24,
                    ),
                  ),
                  const WidgetSpan(
                    child: SizedBox(width: 8),
                  ),
                  TextSpan(
                    text: controller.selectedDate.value.toDateReadable(),
                    style: kTheme.textTheme.titleLarge?.copyWith(
                      color: kTheme.colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: ' (${controller.events.data.value.length} nhắc nhở)',
                    style: kTheme.textTheme.titleLarge?.copyWith(
                      color: kTheme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            trailing: !controller.selectedDate.value.isBetween(
              DateTime.now().firstTimeOfDate(),
              controller.taskModel.duedate.lastTimeOfDate(),
            )
                ? null
                : FilledButton.tonal(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.square(28),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(8),
                    ),
                    onPressed: controller.onAddTaskEvent,
                    child: Icon(
                      Icons.add,
                      color: kTheme.colorScheme.primary,
                      size: 18,
                    ),
                  ),
          ),
          Obx(
            () {
              switch (controller.events.state.value) {
                case LoadingState.initial:
                case LoadingState.loading:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case LoadingState.success:
                  return TaskReminderView(
                    data: controller.events.data.value,
                  );
                case LoadingState.error:
                  return const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('Có lỗi xảy ra, vui lòng thử lại sau.'),
                    ),
                  );
                case LoadingState.empty:
                  return SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.notifications_off,
                          size: 48,
                          color: Colors.grey,
                        ),
                        kGapH8,
                        const Center(
                          child: Text('Hiện không có nhắc nhở nào.'),
                        ),
                        kGapH8,
                        FilledButton.tonal(
                          onPressed: controller.loadTaskEventReminderModel,
                          child: const Text('Tải lại'),
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
  }
}
