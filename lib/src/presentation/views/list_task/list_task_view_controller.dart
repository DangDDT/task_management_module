// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';
import 'package:task_management_module/src/domain/requests/get_task_wedding_param.dart';
import 'package:task_management_module/src/domain/requests/put_status_task_body.dart';
import 'package:task_management_module/src/domain/services/task_service.dart';
import 'package:task_management_module/src/presentation/shared/toast.dart';

import '../../../../core/core.dart';
import '../../../../core/utils/helpers/logger.dart';
import '../../../domain/models/task_model.dart';
import 'widgets/filter_task_bottom_sheet.dart';

class ListTaskViewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ListTaskTab? initialTabType;
  final ITaskService _taskService = Get.find();

  ListTaskViewController({
    this.initialTabType,
  });

  ///Configs
  final ModuleConfig moduleConfig = Get.find(tag: ModuleConfig.tag);

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
  final List<TaskProgressEnum> taskWillShowFilter = [
    TaskProgressEnum.all,
    TaskProgressEnum.toDo,
    TaskProgressEnum.inProgress,
    TaskProgressEnum.done,
  ];

  ///Controllers
  TextEditingController searchController = TextEditingController();
  final PagingController<int, TaskWeddingModel> pagingController =
      PagingController(firstPageKey: 0, invisibleItemsThreshold: 10);
  final ScrollController scrollController = ScrollController();

  late final TabController tabController;

  ///States
  final Rx<int> currentPage = 0.obs;
  final Rx<String> searchText = ''.obs;
  late final Rx<ListTaskTab> selectedTab =
      initialTabType != null ? initialTabType!.obs : ListTaskTab.all().obs;
  final Rxn<FilterTask> filter = Rxn<FilterTask>();

  @override
  onInit() {
    super.onInit();
    tabController = TabController(
      length: moduleConfig.tabsInTaskView != null
          ? moduleConfig.tabsInTaskView!.length
          : ListTaskTab.defaultTabs.length,
      vsync: this,
    );
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
    super.onClose();
  }

  Future<void> onChangeTab(int index) async {
    selectedTab.value = moduleConfig.tabsInTaskView != null
        ? moduleConfig.tabsInTaskView![index]
        : ListTaskTab.defaultTabs[index];
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
      final newItems = await _taskService.getTaskWeddings(
        GetTaskWeddingParam(
          pageIndex: pageKey,
          pageSize: _pageSize,
          orderBy: 'CreateDate',
          orderType: 'DESC',
          dueDateFrom: null,
          dueDateTo: null,
          status: selectedTab.value.tabType.isAll
              ? null
              : [
                  selectedTab.value.tabType.toCode(),
                ],
          taskName:
              searchController.text.isEmpty ? null : searchController.text,
        ),
      );
      // Dummy.getDummyTasks(
      //   GetTaskListParam(
      //     pageSize: _pageSize,
      //     pageIndex: currentPage.value,
      //     searchKey: searchController.text,
      //     duedateFrom: filter.value?.duedate,
      //     duedateTo: filter.value?.duedate?.add(const Duration(days: 1)),
      //     taskStatusCodes: [
      //       selectedTab.value.tabType.toCode(),
      //     ],
      //   ),
      // );
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
      currentPage.value++;
    } catch (error, stackTrace) {
      Logger.log(error.toString(),
          name: 'ListTaskViewController_fetchPage', stackTrace: stackTrace);
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

  Future<void> onTapTaskCard(TaskWeddingModel item) async {
    await Get.toNamed(
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
        'imageEvidenceUrl':
            item.evidence != null ? item.evidence!.evidenceValue : null,
      },
    );
    await onRefreshList();
  }

  Future<void> onStartTask(String taskId) async {
    try {
      final confirm = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có chắc chắn muốn bắt đầu công việc này?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Đồng ý'),
            ),
          ],
        ),
      );
      if (confirm == null || !confirm) {
        return;
      }
      final result = await _taskService.putStatusTask(
        taskId,
        PutStatusTaskBody(
          status: TaskProgressEnum.inProgress.toCode(),
          imageEvidenceUrl: null,
        ),
      );
      if (result) {
        Toast.showSuccess(message: 'Bắt đầu công việc thành công');
        await onRefreshList();
      } else {
        Toast.showError(message: 'Bắt đầu công việc thất bại');
      }
    } catch (e) {
      Logger.log(e.toString(), name: 'TaskDetailController - onStartTask()');
      Toast.showError(message: 'Có lỗi xảy ra, vui lòng thử lại sau');
    }
  }

  Future<void> onCompleteTask(String taskId) async {
    final isCompleteDone = await Get.toNamed(
      RouteConstants.completeTaskRoute,
      arguments: {
        'taskId': taskId,
      },
    );
    if (isCompleteDone == null) {
      return;
    }
    if (isCompleteDone) {
      await onRefreshList();
    }
  }
}

class ListTaskTab {
  final TaskProgressEnum tabType;
  const ListTaskTab({required this.tabType});

  factory ListTaskTab.all() => const ListTaskTab(
        tabType: TaskProgressEnum.all,
      );
  factory ListTaskTab.expected() => const ListTaskTab(
        tabType: TaskProgressEnum.expected,
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

  static List<ListTaskTab> get defaultTabs => [
        ListTaskTab.all(),
        ListTaskTab.expected(),
        ListTaskTab.toDo(),
        ListTaskTab.inProgress(),
        ListTaskTab.done(),
      ];
}
