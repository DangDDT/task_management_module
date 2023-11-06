// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';
import 'package:task_management_module/src/domain/models/task_model.dart';
import 'package:task_management_module/src/domain/models/task_order_detail.dart';
import 'package:task_management_module/src/presentation/shared/circle_avatar_with_error_handler.dart';
import 'package:task_management_module/src/presentation/views/task_detail/task_detail_view_controller.dart';
import 'package:task_management_module/src/presentation/widgets/state_render.dart';
import 'package:task_management_module/src/presentation/widgets/task_wedding_card.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../shared/custom_chip.dart';
import '../task_reminder/task_reminder_view.dart';
import 'widgets/comment_task/comment_task_view.dart';
import 'widgets/task_note_view.dart';

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({
    super.key,
    required this.taskId,
    required this.name,
    required this.description,
    required this.duedate,
    required this.taskMasterName,
    required this.customerName,
    required this.serviceNames,
    required this.status,
    this.heroTag,
  });
  final dynamic taskId;
  final String name;
  final String description;
  final DateTime duedate;
  final String taskMasterName;
  final String customerName;
  final List<String> serviceNames;
  final String? heroTag;
  final TaskProgressEnum status;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskDetailViewController>(
      init: TaskDetailViewController(id: taskId),
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchData();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:
                          kTheme.colorScheme.primaryContainer.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Obx(
                      () {
                        var taskServiceCard = TaskWeddingCard(
                          taskId: taskId,
                          name: name,
                          description: description,
                          duedate: duedate,
                          taskMasterName: taskMasterName,
                          customerName: customerName,
                          serviceNames: serviceNames,
                          status: status,
                          config: TaskServiceCardViewConfig(
                            taskNameStyle:
                                kTheme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: kTheme.colorScheme.primary,
                            ),
                            isShowDescription: false,
                            isShowDueDate: controller
                                .taskModel.data.value.status.isInProgress,
                            isShowTag: false,
                            isFilled: false,
                          ),
                        );
                        return _TaskSection(
                          taskId: taskId,
                          taskServiceCard: taskServiceCard,
                          heroTag: heroTag,
                        );
                      },
                    ),
                  ),
                  kGapH12,
                  Obx(
                    () {
                      return StateRender<List<TaskWeddingModel>,
                          TaskWeddingModel>(
                        state: controller.taskModel.state.value,
                        data: [controller.taskModel.data.value],
                        layoutBuilder: (_, itemBuilder) => itemBuilder(
                          controller.taskModel.data.value,
                          0,
                        ),
                        itemBuilder: (item, _) => _DataView(item: item),
                        isAnimation: true,
                        duration: const Duration(milliseconds: 610),
                        verticalSlideOffset: 0.0,
                        horizontalSlideOffset: 50.0,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DataView extends StatelessWidget {
  final TaskWeddingModel item;
  const _DataView({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          height: 12,
          indent: 8,
          thickness: 5.0,
          endIndent: 200,
        ),
        if (item.taskMaster != null) ...[
          _ServiceTitle(item: item),
          kGapH8,
          _TaskMasterSection(item: item),
        ] else
          kGapH12,
        kGapH4,
        _TaskOrderDetailsSection(
          item: item,
        ),
        kGapH8,
        const Divider(
          height: 16,
          indent: 32,
          thickness: 2.0,
          endIndent: 32,
        ),
        kGapH8,
        _CustomerSection(item: item),
        kGapH8,
        if (item.status.isInProgress) ...[
          const Divider(
            height: 16,
            indent: 32,
            thickness: 2.0,
            endIndent: 32,
          ),
          const _TaskNoteSection(),
          kGapH16,
          const Divider(
            height: 16,
            indent: 32,
            thickness: 2.0,
            endIndent: 32,
          ),
          _TaskReminderSection(item: item),
          kGapH16,
        ],
        if (item.status.isInProgress ||
            item.status.isTodo ||
            item.status.isDone) ...[
          const Divider(),
          _CommentSection(item: item),
        ],
      ],
    );
  }
}

class _TaskNoteSection extends StatelessWidget {
  const _TaskNoteSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TaskNoteView();
  }
}

class _TaskReminderSection extends GetView<TaskDetailViewController> {
  final TaskWeddingModel item;
  const _TaskReminderSection({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.solidBell,
                    color: kTheme.colorScheme.primary,
                    size: 24,
                  ),
                  kGapW8,
                  Text(
                    'Nhắc nhở công việc',
                    style: kTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kTheme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              TextButton(
                style: IconButton.styleFrom(
                  minimumSize: const Size.square(28),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(8),
                ),
                onPressed: controller.goToTaskReminder,
                child: Text(
                  'Xem thêm',
                  style: kTheme.textTheme.bodyMedium?.copyWith(
                    color: kTheme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          kGapH16,
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
                    onTap: (event, index) async {
                      await Get.toNamed(
                        RouteConstants.taskReminderRoute,
                        arguments: {
                          'taskModel': item,
                          'selectedDate': event.eventAt,
                        },
                      );
                      await controller.loadTaskEventReminderModel();
                    },
                  );
                case LoadingState.error:
                  return const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('Có lỗi xảy ra, vui lòng thử lại sau.'),
                    ),
                  );
                case LoadingState.empty:
                  return const SizedBox(
                    height: 100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidBellSlash,
                            color: Colors.grey,
                            size: 24,
                          ),
                          kGapH8,
                          Text('Hôm nay không có nhắc nhở nào cả.'),
                        ],
                      ),
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

class _ServiceTitle extends GetView<TaskDetailViewController> {
  final TaskWeddingModel item;
  const _ServiceTitle({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Chi tiết công việc',
            style: kTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: kTheme.colorScheme.onBackground,
            ),
          ),
          Row(
            children: [
              if (item.taskMaster?.phoneNumber.isNotEmpty ?? false)
                IconButton.filledTonal(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(0.8),
                    minimumSize: const Size.square(28),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  onPressed: () => controller.call(
                    item.taskMaster?.phoneNumber ?? '',
                  ),
                  icon: Icon(
                    Icons.phone,
                    color: kTheme.colorScheme.onPrimary,
                    size: 18,
                  ),
                ),
              if (item.taskMaster?.phoneNumber.isNotEmpty ?? false)
                IconButton.filledTonal(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.8),
                    minimumSize: const Size.square(28),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  onPressed: () => controller.sendSms(
                    item.taskMaster?.phoneNumber ?? '',
                  ),
                  icon: Icon(
                    Icons.sms,
                    color: kTheme.colorScheme.onPrimary,
                    size: 18,
                  ),
                ),
              if (item.taskMaster?.email.isNotEmpty ?? false)
                IconButton.filledTonal(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue.withOpacity(0.8),
                    minimumSize: const Size.square(28),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  onPressed: () => controller.sendEmail(
                    item.taskMaster?.email ?? '',
                  ),
                  icon: Icon(
                    Icons.email,
                    color: kTheme.colorScheme.onPrimary,
                    size: 18,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TaskMasterSection extends StatelessWidget {
  const _TaskMasterSection({
    required this.item,
  });
  final TaskWeddingModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.personCircleCheck,
                    color: kTheme.colorScheme.primary,
                    size: 18,
                  ),
                  kGapW8,
                  Text(
                    'Người giao',
                    style: kTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kTheme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              kGapH12,
              Row(
                children: [
                  CircleAvatarWithErrorHandler(
                    avatarUrl: item.taskMaster?.avatar,
                    fullName: item.taskMaster?.name,
                  ),
                  kGapW8,
                  Text(
                    item.taskMaster?.name ?? 'Không có dữ liệu',
                    style: kTheme.textTheme.titleMedium?.copyWith(
                      color: kTheme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
          kGapH8,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.calendarCheck,
                    color: kTheme.colorScheme.primary,
                    size: 18,
                  ),
                  kGapW8,
                  Text(
                    'Ngày giao',
                    style: kTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kTheme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              kGapH12,
              Text(
                item.createdDate.toFullString(),
                style: kTheme.textTheme.titleMedium?.copyWith(
                  color: kTheme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _TaskOrderDetailsSection extends StatelessWidget {
  final TaskWeddingModel item;
  const _TaskOrderDetailsSection({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final count = item.orderDetails.length;
    final isShowCount = count > 1;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.list,
                color: kTheme.colorScheme.primary,
                size: 18,
              ),
              kGapW8,
              Text(
                'Dịch vụ cần cung cấp ${isShowCount ? '($count)' : ''}',
                style: kTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kTheme.colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
        kGapH12,
        if (item.orderDetails.length == 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 200,
              child: _OrderDetailCard(
                taskOrderDetail: item.orderDetails.first,
                index: 0,
                isFullWidth: true,
                isShowCount: false,
              ),
            ),
          ),
        if (item.orderDetails.length > 1)
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: item.orderDetails.length,
              itemBuilder: (context, index) {
                final taskOrderDetail = item.orderDetails[index];
                return _OrderDetailCard(
                  taskOrderDetail: taskOrderDetail,
                  index: index,
                );
              },
              separatorBuilder: (context, index) => kGapW8,
            ),
          ),
      ],
    );
  }
}

class _OrderDetailCard extends GetView<TaskDetailViewController> {
  const _OrderDetailCard({
    super.key,
    required this.taskOrderDetail,
    required this.index,
    this.isFullWidth = false,
    this.isShowCount = true,
  });

  final TaskOrderDetailModel taskOrderDetail;
  final int index;
  final bool isFullWidth;
  final bool isShowCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onTapOrderDetailCard(taskOrderDetail),
      child: Container(
        width: isFullWidth ? null : MediaQuery.of(context).size.width * 0.7,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: kTheme.colorScheme.primary,
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${isShowCount ? '${index + 1}.' : ''} ${taskOrderDetail.service.name} ',
                    style: kTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kTheme.colorScheme.onBackground,
                    ),
                  ),
                ),
                kGapW8,
                CustomChip(
                  title: taskOrderDetail.service.unit,
                  color: kTheme.colorScheme.primary,
                ),
              ],
            ),
            kGapH8,
            _RowServiceData(
              icon: Icons.attach_money,
              title: 'Giá cung cấp',
              content: taskOrderDetail.price.toInt().toVietNamCurrency(),
              contentColor: kTheme.colorScheme.primary,
              titleStyle: kTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: kTheme.colorScheme.onBackground,
              ),
              contentStyle: kTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            kGapH8,
            _RowServiceData(
              icon: Icons.percent,
              title: 'Chiết khấu',
              content: '${taskOrderDetail.commission.toStringAsPrecision(2)} %',
              contentColor: kTheme.colorScheme.primary,
              titleStyle: kTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: kTheme.colorScheme.onBackground,
              ),
              contentStyle: kTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: kTheme.colorScheme.onBackground.withOpacity(0.5),
              ),
            ),
            const Divider(),
            _RowServiceData(
              icon: Icons.attach_money,
              title: 'Doanh thu dự kiến',
              content: taskOrderDetail.revenue.toInt().toVietNamCurrency(),
              titleStyle: kTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: kTheme.colorScheme.onBackground,
              ),
              contentStyle: kTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: kTheme.colorScheme.primary,
              ),
            ),
            kGapH4,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                taskOrderDetail.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: kTheme.textTheme.bodySmall?.copyWith(
                  color: kTheme.colorScheme.onBackground.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentSection extends StatelessWidget {
  const _CommentSection({
    required this.item,
  });

  final TaskWeddingModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.solidCommentDots,
                color: kTheme.colorScheme.primary,
                size: 24,
              ),
              kGapW8,
              Text(
                'Trao đổi công việc',
                style: kTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kTheme.colorScheme.onBackground,
                ),
              ),
            ],
          ),
          kGapH16,
          CommentTaskView(taskId: item.id),
        ],
      ),
    );
  }
}

class _TaskSection extends StatelessWidget {
  const _TaskSection({
    required this.taskId,
    required this.taskServiceCard,
    this.heroTag,
  });

  final dynamic taskId;
  final TaskWeddingCard taskServiceCard;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag ?? const Uuid().v4(),
      flightShuttleBuilder: (
        context,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        return SizeTransition(
          sizeFactor: animation,
          child: SingleChildScrollView(
            child: taskServiceCard,
          ),
        );
      },
      child: taskServiceCard,
    );
  }
}

class _CustomerSection extends GetView<TaskDetailViewController> {
  final TaskWeddingModel item;
  const _CustomerSection({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Thông tin khách hàng',
                  style: kTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kTheme.colorScheme.onBackground,
                  ),
                ),
                Row(
                  children: [
                    if (item.customer.phoneNumber.isNotEmpty)
                      IconButton.filledTonal(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.green.withOpacity(0.8),
                          minimumSize: const Size.square(28),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(8),
                        ),
                        onPressed: () => controller.call(
                          item.customer.phoneNumber,
                        ),
                        icon: Icon(
                          Icons.phone,
                          color: kTheme.colorScheme.onPrimary,
                          size: 18,
                        ),
                      ),
                    if (item.customer.phoneNumber.isNotEmpty)
                      IconButton.filledTonal(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.8),
                          minimumSize: const Size.square(28),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(8),
                        ),
                        onPressed: () => controller.sendSms(
                          item.customer.phoneNumber,
                        ),
                        icon: Icon(
                          Icons.sms,
                          color: kTheme.colorScheme.onPrimary,
                          size: 18,
                        ),
                      ),
                    if (item.customer.email.isNotEmpty)
                      IconButton.filledTonal(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.blue.withOpacity(0.8),
                          minimumSize: const Size.square(28),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(8),
                        ),
                        onPressed: () => controller.sendEmail(
                          item.customer.email,
                        ),
                        icon: Icon(
                          Icons.email,
                          color: kTheme.colorScheme.onPrimary,
                          size: 18,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            kGapH16,
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: kTheme.colorScheme.primary,
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.user,
                                  color: kTheme.colorScheme.primary,
                                  size: 18,
                                ),
                                kGapW8,
                                Text(
                                  'Họ và tên',
                                  style: kTheme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: kTheme.colorScheme.onBackground,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CircleAvatarWithErrorHandler(
                                  avatarUrl: item.customer.avatar,
                                  fullName: item.customer.fullName,
                                ),
                                kGapW8,
                                Text(
                                  item.customer.fullName,
                                  style: kTheme.textTheme.titleSmall?.copyWith(
                                    color: kTheme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        kGapH8,
                        _RowServiceData(
                          icon: Icons.phone,
                          title: 'Số điện thoại',
                          content: item.customer.phoneNumber,
                        ),
                        kGapH8,
                        _RowServiceData(
                          icon: Icons.email,
                          title: 'Email',
                          content: item.customer.email,
                        ),
                        kGapH8,
                        _RowServiceData(
                          icon: Icons.location_on,
                          title: 'Địa chỉ',
                          content: item.customer.address,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RowServiceData extends StatelessWidget {
  const _RowServiceData({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
    this.contentColor,
    this.titleStyle,
    this.contentStyle,
  });
  final IconData icon;
  final String title;
  final String content;
  final Color? contentColor;
  final TextStyle? titleStyle;
  final TextStyle? contentStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: kTheme.colorScheme.primary,
              size: 18,
            ),
            kGapW8,
            Text(
              title,
              style: titleStyle ??
                  kTheme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kTheme.colorScheme.onBackground,
                  ),
            ),
          ],
        ),
        Text(
          content,
          style: contentStyle ??
              kTheme.textTheme.titleSmall?.copyWith(
                color: contentColor ?? kTheme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
