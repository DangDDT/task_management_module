// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';

import '../../../../core/core.dart';
import '../../../domain/mock/dummy.dart';
import '../../../domain/models/task_model.dart';
import '../../../domain/requests/get_task_list_param.dart';
import 'widgets/filter_task_bottom_sheet.dart';

class ListTaskViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ///Constants
  static const _pageSize = 20;
  final List<TaskProgressEnum> taskWillShowActions = [
    TaskProgressEnum.toDo,
    TaskProgressEnum.inProgress,
  ];
  final List<TaskProgressEnum> taskWillShowDueDate = [
    TaskProgressEnum.toDo,
    TaskProgressEnum.inProgress,
  ];

  ///Controllers
  TextEditingController searchController = TextEditingController();
  final PagingController<int, TaskWeddingModel> pagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 10);
  final ScrollController scrollController = ScrollController();

  late final TabController tabController = TabController(
    length: ListTaskTab.tabs.length,
    vsync: this,
  );

  ///States
  final Rx<int> currentPage = 0.obs;
  final Rx<String> searchText = ''.obs;
  final Rx<ListTaskTab> selectedTab = ListTaskTab.all().obs;

  final Rxn<FilterTask> filter = Rxn<FilterTask>();

  @override
  onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    searchController.addListener(() {
      if (searchController.text == searchText.value) return;
      currentPage.value = 0;
      pagingController.refresh();
      searchText.value = searchController.text;
    });
  }

  @override
  onClose() {
    searchController.dispose();
    pagingController.dispose();
    super.onClose();
  }

  Future<void> onChangeTab(int index) async {
    selectedTab.value = ListTaskTab.tabs[index];
    currentPage.value = 0;
    pagingController.refresh();
  }

  Future<void> onFilterButtonPressed() async {
    final result = await Get.bottomSheet<FilterTask>(
      FilterTaskBottomSheet(
        selectedFilterTask: filter.value,
      ),
      isScrollControlled: true,
    );

    if (result != null) {
      filter.value = result;
      currentPage.value = 0;
      pagingController.refresh();
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      await Future.delayed(Duration(seconds: faker.randomGenerator.integer(3)));
      final newItems = Dummy.getDummyTasks(
        GetTaskListParam(
          pageSize: _pageSize,
          pageIndex: currentPage.value,
          searchKey: searchController.text,
          duedateFrom: filter.value?.duedate,
          duedateTo: filter.value?.duedate?.add(const Duration(days: 1)),
          taskStatusCodes: [
            selectedTab.value.tabType.toCode(),
          ],
        ),
      );
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
      currentPage.value++;
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> onClearSearchField() async {
    searchController.clear();
    currentPage.value = 0;
    pagingController.refresh();
  }

  Future<void> onRefreshList() async {
    currentPage.value = 0;
    pagingController.refresh();
  }

  Future<void> onTapTaskCard(TaskWeddingModel item, String? heroTag) async {
    Get.toNamed(
      RouteConstants.taskDetailRoute,
      arguments: {
        'taskId': item.id,
        'name': item.name,
        'description': item.description,
        'duedate': item.duedate,
        'taskMasterName': item.taskMaster?.name,
        'customerName': item.customer.fullName,
        'serviceNames': item.orderDetails.map((e) => e.service.name).toList(),
        'status': item.status,
        'heroTag': heroTag,
      },
    );
  }
}

class ListTaskTab {
  final TaskProgressEnum tabType;
  const ListTaskTab({required this.tabType});

  factory ListTaskTab.all() => const ListTaskTab(
        tabType: TaskProgressEnum.all,
      );
  factory ListTaskTab.toDo() => const ListTaskTab(
        tabType: TaskProgressEnum.toDo,
      );
  factory ListTaskTab.inProgress() => const ListTaskTab(
        tabType: TaskProgressEnum.inProgress,
      );
  factory ListTaskTab.done() => const ListTaskTab(
        tabType: TaskProgressEnum.done,
      );

  static List<ListTaskTab> get tabs => [
        ListTaskTab.all(),
        ListTaskTab.toDo(),
        ListTaskTab.inProgress(),
        ListTaskTab.done(),
      ];
}
