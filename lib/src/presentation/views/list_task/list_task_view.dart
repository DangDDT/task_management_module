import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';
import 'package:task_management_module/src/domain/models/task_model.dart';
import 'package:task_management_module/src/presentation/views/list_task/list_task_view_controller.dart';
import 'package:task_management_module/src/presentation/widgets/custom_text_field.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/task_wedding_card.dart';

class ListTaskView extends StatelessWidget {
  const ListTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListTaskViewController>(
      init: ListTaskViewController(),
      builder: (_) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  children: [
                    Expanded(child: _TaskSearchField()),
                    kGapW8,
                    _TaskFilterButton(),
                  ],
                ),
              ),
              _TaskTabBar(),
              kGapH12,
              Expanded(child: _TaskListBuilder())
            ],
          ),
        );
      },
    );
  }
}

class _TaskSearchField extends GetView<ListTaskViewController> {
  const _TaskSearchField();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomTextField(
        labelText: 'Nhập tên công việc',
        prefixIcon: Icons.search,
        suffixIcon: controller.searchText.value.isNotEmpty
            ? IconButton(
                onPressed: controller.onClearSearchField,
                icon: const Icon(Icons.close_rounded),
              )
            : null,
        controller: controller.searchController,
        borderTransparent: true,
      ),
    );
  }
}

class _TaskFilterButton extends GetView<ListTaskViewController> {
  const _TaskFilterButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: controller.onFilterButtonPressed,
      style: FilledButton.styleFrom(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.comfortable,
        fixedSize: const Size(40, 46),
      ),
      child: const Icon(
        Icons.filter_list,
        size: 24,
      ),
    );
  }
}

class _TaskTabBar extends GetView<ListTaskViewController> {
  const _TaskTabBar();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      controller: controller.tabController,
      onTap: controller.onChangeTab,
      isScrollable: true,
      indicatorColor: Colors.grey,
      indicatorPadding: const EdgeInsets.symmetric(vertical: 4.0),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: kTheme.colorScheme.primary,
      ),
      labelColor: kTheme.colorScheme.onPrimary,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.tab,
      splashFactory: NoSplash.splashFactory,
      labelStyle: kTheme.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: kTheme.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.normal,
      ),
      dividerColor: Colors.transparent,
      tabs: ListTaskTab.tabs
          .map(
            (e) => Tab(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  e.tabType.name,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _TaskListBuilder extends GetView<ListTaskViewController> {
  const _TaskListBuilder();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.onRefreshList,
      child: PagedListView<int, TaskWeddingModel>.separated(
        physics: const BouncingScrollPhysics(),
        pagingController: controller.pagingController,
        scrollController: controller.scrollController,
        shrinkWrap: true,
        builderDelegate: PagedChildBuilderDelegate<TaskWeddingModel>(
          itemBuilder: (context, item, index) => TaskWeddingItem(
            item: item,
          ),
          noMoreItemsIndicatorBuilder: (context) => const _NoMoreItem(),
          firstPageProgressIndicatorBuilder: (context) => const _LoadingItem(),
          firstPageErrorIndicatorBuilder: (context) => const _ErrorItem(),
          newPageErrorIndicatorBuilder: (context) => const _ErrorItem(),
          newPageProgressIndicatorBuilder: (context) => const _LoadingItem(),
          noItemsFoundIndicatorBuilder: (context) => const _NoMoreItem(),
          animateTransitions: true,
          transitionDuration: const Duration(milliseconds: 410),
        ),
        separatorBuilder: (context, index) => kGapH8,
      ),
    );
  }
}

class TaskWeddingItem extends GetView<ListTaskViewController> {
  final TaskWeddingModel item;
  const TaskWeddingItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final heroTag = const Uuid().v4();
    return GestureDetector(
      onTap: () => controller.onTapTaskCard(item, heroTag),
      child: Hero(
        tag: heroTag,
        child: TaskWeddingCard.item(
          item: item,
          config: TaskServiceCardViewConfig(
            isShowDescription: false,
            isShowDueDate: controller.taskWillShowDueDate.contains(item.status),
            isShowTag: true,
            isShowFullName: true,
            isShowFullDescription: true,
            isShowStatus: true,
            isShowServiceName: true,
            isShowCustomerName: true,
            actionConfig: controller.taskWillShowActions.contains(item.status)
                ? ActionConfig(
                    actions: [
                      ///TODO: Add action for task
                      ///
                      if (item.status == TaskProgressEnum.toDo)
                        ActionItem(
                          icon: Icons.play_arrow_rounded,
                          actionLabel: 'Bắt đầu thực hiện',
                          onTap: () {},
                        ),

                      ///TODO: Add action for task
                      if (item.status == TaskProgressEnum.inProgress)
                        ActionItem(
                          icon: Icons.check,
                          actionLabel: 'Báo cáo hoàn thành',
                          onTap: () {},
                        ),
                    ],
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class _NoMoreItem extends StatelessWidget {
  const _NoMoreItem();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: Text('Không còn công việc nào nữa'),
      ),
    );
  }
}

class _LoadingItem extends StatelessWidget {
  const _LoadingItem();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: (MediaQuery.of(context).size.height / 2) - 150),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ErrorItem extends StatelessWidget {
  const _ErrorItem();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Đã có lỗi xảy ra, vui lòng thử lại sau'),
    );
  }
}
