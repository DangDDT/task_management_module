// ignore_for_file: unused_element

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_preview/image_preview.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';
import 'package:task_management_module/src/domain/models/task_model.dart';
import 'package:task_management_module/src/domain/models/task_order_detail.dart';
import 'package:task_management_module/src/presentation/shared/circle_avatar_with_error_handler.dart';
import 'package:task_management_module/src/presentation/views/task_detail/task_detail_view_controller.dart';
import 'package:task_management_module/src/presentation/widgets/state_render.dart';
import 'package:task_management_module/src/presentation/widgets/task_wedding_card.dart';

import '../../../../core/core.dart';
import '../../../domain/domain.dart';
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
  });
  final dynamic taskId;
  final String name;
  final String description;
  final DateTime duedate;
  final String taskMasterName;
  final String customerName;
  final List<String> serviceNames;
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
        kGapH8,
        _TaskTitle(item: item),
        kGapH12,
        _TaskDetailsSection(
          item: item,
        ),
        Divider(
          height: 32,
          indent: Get.width * 0.6,
          thickness: 1.0,
          color: kTheme.dividerColor,
        ),
        _ServiceTitle(item: item),
        kGapH12,
        _TaskOrderDetailsSection(
          item: item,
        ),
        kGapH8,
        Divider(
          height: 32,
          indent: Get.width * 0.6,
          thickness: 1.0,
          color: kTheme.dividerColor,
        ),
        kGapH8,
        _CustomerSection(item: item),
        kGapH8,
        if (item.status.isInProgress || item.status.isTodo) ...[
          const Divider(
            height: 16,
            indent: 32,
            thickness: 2.0,
            endIndent: 32,
          ),
          const _TaskNoteSection(),
          kGapH16,
          if (item.duedate.lastTimeOfDate().isAfter(DateTime.now())) ...[
            const Divider(
              height: 16,
              indent: 32,
              thickness: 2.0,
              endIndent: 32,
            ),
            _TaskReminderSection(item: item),
            kGapH16,
          ],
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
            'Dịch vụ cần cung cấp',
            style: kTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: kTheme.colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskTitle extends GetView<TaskDetailViewController> {
  final TaskWeddingModel item;
  const _TaskTitle({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Thông tin công việc',
            style: kTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: kTheme.colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskMasterSection extends GetView<TaskDetailViewController> {
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 610),
        child: Container(
          decoration: BoxDecoration(
            color: kTheme.colorScheme.primaryContainer.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: kTheme.colorScheme.primary,
              width: 1.0,
            ),
          ),
          padding: const EdgeInsets.all(8.0),
          child: _OrderDetailSection(
            taskOrderDetail: [item.orderDetail].first,
          ),
        ),
      ),
    );
  }
}

class _TaskDetailsSection extends StatelessWidget {
  final TaskWeddingModel item;
  const _TaskDetailsSection({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 610),
        child: Container(
          decoration: BoxDecoration(
            color: kTheme.colorScheme.primaryContainer.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: kTheme.colorScheme.primary,
              width: 1.0,
            ),
          ),
          padding: const EdgeInsets.all(8.0),
          child: _TaskDetailSection(
            taskOrderDetail: [item.orderDetail].first,
          ),
        ),
      ),
    );
  }
}

class _OrderDetailSection extends GetView<TaskDetailViewController> {
  const _OrderDetailSection({
    super.key,
    required this.taskOrderDetail,
  });

  final TaskOrderDetailModel taskOrderDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RowServiceData(
          icon: Icons.room_service_sharp,
          title: 'Tên dịch vụ',
          content: taskOrderDetail.service.name,
          contentColor: kTheme.colorScheme.primary,
          titleStyle: kTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: kTheme.colorScheme.onBackground,
          ),
          contentStyle: kTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        kGapH4,
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.image,
                    color: kTheme.colorScheme.primary,
                    size: 18,
                  ),
                  kGapW8,
                  Text(
                    'Hình ảnh',
                    style: kTheme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kTheme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ...taskOrderDetail.service.images
                      .take(4)
                      .map(
                        (e) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: GestureDetector(
                            onTap: () {
                              openImagesPage(
                                Navigator.of(context),
                                imgUrls: taskOrderDetail.service.images,
                                index:
                                    taskOrderDetail.service.images.indexOf(e),
                                heroTags: taskOrderDetail.service.images
                                    .map((e) => e.hashCode.toString())
                                    .toList(),
                              );
                            },
                            child: ExtendedImage.network(
                              e,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                      .toList()
                      .joinWidget(kGapW8),
                  if (taskOrderDetail.service.images.length > 4) ...[
                    kGapW8,
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          '+${taskOrderDetail.service.images.length - 4}',
                          style: kTheme.textTheme.titleMedium?.copyWith(
                            color: kTheme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        kGapH8,
        _RowServiceData(
          icon: Icons.category,
          title: 'Đơn vị tính',
          content: taskOrderDetail.service.unit.isNotNullOrEmpty
              ? '(${taskOrderDetail.service.unit.trim()})'
              : '< Chưa có thông tin >',
          contentColor: kTheme.colorScheme.primary,
          titleStyle: kTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: kTheme.colorScheme.onBackground,
          ),
          contentStyle: kTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: kTheme.colorScheme.onBackground.withOpacity(0.5),
          ),
        ),
        kGapH16,
        _RowServiceData(
          icon: Icons.description,
          title: 'Mô tả',
          content: taskOrderDetail.service.description,
          contentColor: kTheme.colorScheme.primary,
          titleStyle: kTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: kTheme.colorScheme.onBackground,
          ),
          contentStyle: kTheme.textTheme.labelMedium?.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
        kGapH16,
        _RowServiceData(
          icon: Icons.attach_money,
          title: 'Giá dịch vụ',
          content: taskOrderDetail.service.price.toInt().toVietNamCurrency(),
          contentColor: kTheme.colorScheme.primary,
          titleStyle: kTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: kTheme.colorScheme.onBackground,
          ),
          contentStyle: kTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (controller.config.viewByRoleConfig?.isShowComissionValue ??
            false) ...[
          kGapH16,
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
        ],
        if (controller.config.viewByRoleConfig?.isShowRevenueValue ??
            false) ...[
          Divider(
            height: 16,
            indent: Get.width * 0.6,
            thickness: 2.0,
          ),
          _RowServiceData(
            icon: Icons.attach_money,
            title: 'Doanh thu dự kiến',
            content: taskOrderDetail.revenue.toInt().toVietNamCurrency(),
            titleStyle: kTheme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: kTheme.colorScheme.onBackground,
            ),
            contentStyle: kTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: kTheme.colorScheme.primary,
            ),
          ),
        ],
      ],
    );
  }
}

class _TaskDetailSection extends GetView<TaskDetailViewController> {
  const _TaskDetailSection({
    super.key,
    required this.taskOrderDetail,
  });

  final TaskOrderDetailModel taskOrderDetail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RowServiceData(
          icon: Icons.person,
          title: 'Người nhận',
          content: taskOrderDetail.fullName.isEmpty
              ? '< Chưa có thông tin >'
              : taskOrderDetail.fullName,
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
          icon: Icons.add_shopping_cart,
          title: 'Ngày khách cần',
          content: taskOrderDetail.eventDate.toFullString(),
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
          icon: Icons.phone,
          title: 'SĐT người nhận',
          content: taskOrderDetail.phone.isEmpty
              ? '< Chưa có thông tin >'
              : taskOrderDetail.phone,
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
          icon: Icons.location_on,
          title: 'Địa chỉ giao',
          content: taskOrderDetail.address.isEmpty
              ? '< Chưa có thông tin > '
              : taskOrderDetail.address,
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
          icon: Icons.note,
          title: 'Ghi chú của khách hàng',
          content: taskOrderDetail.description.isEmpty
              ? '< Không có ghi chú >'
              : taskOrderDetail.description,
          titleStyle: kTheme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: kTheme.colorScheme.onBackground,
          ),
          contentStyle: kTheme.textTheme.labelLarge?.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class _CommentSection extends GetView<TaskDetailViewController> {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
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
              kGapW8,
              Text(
                '(${item.comments.length})',
                style: kTheme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kTheme.colorScheme.primary,
                ),
              ),
              const Spacer(),
              IconButton.filledTonal(
                style: IconButton.styleFrom(
                  minimumSize: const Size.square(28),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(8),
                ),
                onPressed: controller.onRefreshComments,
                icon: const Icon(
                  Icons.refresh,
                  size: 18,
                ),
              ),
            ],
          ),
          kGapH16,
          CommentTaskView(
            items: item.comments,
            onAddComment: controller.onAddComment,
            fullName: controller.config.userConfig.fullName,
            avatarUrl: controller.config.userConfig.avatar,
          ),
        ],
      ),
    );
  }
}

class _TaskSection extends StatelessWidget {
  const _TaskSection({
    required this.taskId,
    required this.taskServiceCard,
  });

  final dynamic taskId;
  final TaskWeddingCard taskServiceCard;

  @override
  Widget build(BuildContext context) {
    return taskServiceCard;
  }
}

class _CustomerSection extends GetView<TaskDetailViewController> {
  final TaskWeddingModel item;
  const _CustomerSection({required this.item});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 610),
      child: Container(
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
                  color: kTheme.colorScheme.primaryContainer.withOpacity(0.4),
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
                                    style:
                                        kTheme.textTheme.titleSmall?.copyWith(
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
                                    style:
                                        kTheme.textTheme.titleSmall?.copyWith(
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
                            content: item.customer.email.isEmpty
                                ? '< Không có dữ liệu >'
                                : item.customer.email,
                            contentStyle:
                                kTheme.textTheme.labelMedium?.copyWith(
                              color: item.customer.email.isEmpty
                                  ? kTheme.colorScheme.onBackground
                                      .withOpacity(0.5)
                                  : kTheme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Icon(
                icon,
                color: kTheme.colorScheme.primary,
                size: 18,
              ),
              kGapW8,
              Expanded(
                child: Text(
                  title,
                  style: titleStyle ??
                      kTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kTheme.colorScheme.onBackground,
                      ),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Text(
            content,
            textAlign: TextAlign.end,
            style: contentStyle ??
                kTheme.textTheme.titleSmall?.copyWith(
                  color: contentColor ?? kTheme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
