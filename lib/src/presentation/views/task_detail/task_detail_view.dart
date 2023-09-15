import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_management_module/src/domain/models/task_model.dart';
import 'package:task_management_module/src/presentation/shared/circle_avatar_with_error_handler.dart';
import 'package:task_management_module/src/presentation/views/task_detail/task_detail_view_controller.dart';
import 'package:task_management_module/src/presentation/widgets/state_render.dart';
import 'package:task_management_module/src/presentation/widgets/task_card.dart';

import '../../../../core/core.dart';

class TaskDetailView extends StatelessWidget {
  const TaskDetailView({
    super.key,
    required this.taskId,
    required this.name,
    required this.description,
    required this.duedate,
    required this.taskMasterName,
    required this.serviceName,
  });
  final dynamic taskId;
  final String name;
  final String description;
  final DateTime duedate;
  final String taskMasterName;
  final String serviceName;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskDetailViewController>(
      init: TaskDetailViewController(id: taskId),
      tag: 'TaskDetailViewController_$taskId',
      builder: (controller) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: kTheme.colorScheme.primaryContainer.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Obx(
                    () {
                      var taskServiceCard = TaskServiceCard(
                        taskId: taskId,
                        name: name,
                        description: description,
                        duedate: duedate,
                        taskMasterName: taskMasterName,
                        serviceName: serviceName,
                        config: TaskServiceCardViewConfig(
                          isShowDueDate: controller
                              .taskModel.data.value.status.isInProgress,
                          isShowTag: false,
                          isFilled: false,
                        ),
                      );
                      return _TaskCard(
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
        const _ServiceTitle(),
        kGapH8,
        _TaskMasterSection(item: item),
        kGapH4,
        _ServiceSection(item: item),
        kGapH4,
        _NoteSection(item: item),
        kGapH16,
        _CustomerSection(item: item),
        kGapH16,
        _PartnerSection(item: item),
      ],
    );
  }
}

class _ServiceTitle extends StatelessWidget {
  const _ServiceTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Thông tin chi tiết công việc',
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

class _ServiceSection extends StatelessWidget {
  const _ServiceSection({
    required this.item,
  });

  final TaskWeddingModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    FontAwesomeIcons.solidCircleCheck,
                    color: kTheme.colorScheme.primary,
                    size: 18,
                  ),
                  kGapW8,
                  Text(
                    'Dịch vụ',
                    style: kTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kTheme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    item.orderDetail.service.name,
                    style: kTheme.textTheme.titleMedium?.copyWith(
                      color: kTheme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          kGapH12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.solidCalendarCheck,
                    color: kTheme.colorScheme.primary,
                    size: 18,
                  ),
                  kGapW8,
                  Text(
                    'Ngày diễn ra sự kiện',
                    style: kTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kTheme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              Text(
                item.orderDetail.eventDate.toDateReadable(),
                style: kTheme.textTheme.titleMedium?.copyWith(
                  color: kTheme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          kGapH12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.solidMoneyBill1,
                    color: kTheme.colorScheme.primary,
                    size: 18,
                  ),
                  kGapW8,
                  Text(
                    'Đơn giá',
                    style: kTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kTheme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              Text(
                item.orderDetail.service.price.toInt().toVietNamCurrency(),
                style: kTheme.textTheme.titleMedium?.copyWith(
                  color: kTheme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          kGapH12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.format_list_numbered,
                    color: kTheme.colorScheme.primary,
                    size: 18,
                  ),
                  kGapW8,
                  Text(
                    'Số lượng',
                    style: kTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kTheme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              Text(
                '${item.orderDetail.quantity.toInt().numToReadableString()} (${item.orderDetail.service.unit})',
                style: kTheme.textTheme.titleMedium?.copyWith(
                  color: kTheme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          kGapH12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.solidMoneyBill1,
                    color: kTheme.colorScheme.primary,
                    size: 18,
                  ),
                  kGapW8,
                  Text(
                    'Thành tiền',
                    style: kTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kTheme.colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
              Text(
                item.orderDetail.price.toInt().toVietNamCurrency(),
                style: kTheme.textTheme.titleMedium?.copyWith(
                  color: kTheme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
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
      child: Row(
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
                avatarUrl: item.taskMaster.avatar,
                fullName: item.taskMaster.name,
              ),
              kGapW8,
              Text(
                item.taskMaster.name,
                style: kTheme.textTheme.titleMedium?.copyWith(
                  color: kTheme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _NoteSection extends StatelessWidget {
  const _NoteSection({
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
                FontAwesomeIcons.solidNoteSticky,
                color: kTheme.colorScheme.primary,
                size: 18,
              ),
              kGapW8,
              Text(
                'Ghi chú',
                style: kTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kTheme.colorScheme.onBackground,
                ),
              ),
            ],
          ),
          kGapH8,
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: item.notes
                  .map(
                    (e) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '- $e',
                            style: kTheme.textTheme.bodyLarge?.copyWith(
                              color: kTheme.colorScheme.onBackground,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.taskId,
    required this.taskServiceCard,
  });

  final dynamic taskId;
  final TaskServiceCard taskServiceCard;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'TaskServiceCard_$taskId',
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesomeIcons.userGroup,
                  color: kTheme.colorScheme.primary,
                  size: 18,
                ),
                kGapW12,
                Text(
                  'Thông tin khách hàng',
                  style: kTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kTheme.colorScheme.onBackground,
                  ),
                ),
              ],
            ),
            kGapH16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: CircleAvatarWithErrorHandler(
                    avatarUrl: item.orderDetail.customer.avatar,
                    radius: 42,
                    fullName: item.orderDetail.customer.fullName,
                  ),
                ),
                kGapW12,
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RowData(
                        icon: Icons.person,
                        title: item.orderDetail.customer.fullName,
                      ),
                      kGapH4,
                      _RowData(
                        icon: Icons.phone,
                        title: item.orderDetail.customer.phoneNumber,
                      ),
                      kGapH4,
                      _RowData(
                        icon: Icons.email,
                        title: item.orderDetail.customer.email,
                      ),
                      kGapH4,
                      _RowData(
                        icon: Icons.location_on,
                        title: item.orderDetail.customer.address,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PartnerSection extends StatelessWidget {
  final TaskWeddingModel item;
  const _PartnerSection({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.handshake,
                color: kTheme.colorScheme.primary,
                size: 24,
              ),
              kGapW12,
              Text(
                'Thông tin đối tác',
                style: kTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kTheme.colorScheme.onBackground,
                ),
              ),
            ],
          ),
          kGapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: SizedBox(
                  height: 80,
                  child: CircleAvatarWithErrorHandler(
                    avatarUrl: item.orderDetail.partner.avatar,
                    fullName: item.orderDetail.partner.fullName,
                    radius: 48,
                  ),
                ),
              ),
              kGapW12,
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    _RowData(
                      icon: Icons.person,
                      title: item.orderDetail.partner.fullName,
                    ),
                    kGapH4,
                    _RowData(
                      icon: Icons.phone,
                      title: item.orderDetail.partner.phoneNumber,
                    ),
                    kGapH4,
                    _RowData(
                      icon: Icons.email,
                      title: item.orderDetail.partner.email,
                    ),
                    kGapH4,
                    _RowData(
                      icon: Icons.location_on,
                      title: item.orderDetail.partner.address,
                    ),
                    kGapH4,
                    _RowData(
                      icon: Icons.business,
                      title: item.orderDetail.partner.business.name,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RowData extends StatelessWidget {
  const _RowData({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: kTheme.colorScheme.primary,
          size: 20,
        ),
        kGapW8,
        Flexible(
          child: Text(
            title,
            style: kTheme.textTheme.bodyLarge?.copyWith(
              color: kTheme.colorScheme.onBackground,
            ),
          ),
        ),
      ],
    );
  }
}
