// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';

import 'evidence.dart';
import 'task_order_detail.dart';

class BaseTaskModel {
  final dynamic id;
  final String name;
  final String description;
  final DateTime createdDate;
  final DateTime duedate;
  final TaskMasterModel taskMaster;
  final TaskProgressEnum status;
  final List<String> notes;

  BaseTaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdDate,
    required this.duedate,
    required this.taskMaster,
    required this.status,
    required this.notes,
  });
}

class TaskMasterModel {
  final dynamic id;
  final String avatar;
  final String name;
  final String? description;
  final Map<String, dynamic>? refData;
  TaskMasterModel({
    required this.id,
    required this.name,
    required this.avatar,
    this.description,
    this.refData,
  });

  factory TaskMasterModel.loading() {
    return TaskMasterModel(
      id: -1,
      name: 'Đang tải...',
      avatar: 'Đang tải...',
    );
  }

  factory TaskMasterModel.error() {
    return TaskMasterModel(
      id: -1,
      name: 'Không có dữ liệu',
      avatar: 'Không có dữ liệu',
    );
  }
}

class TaskWeddingModel extends BaseTaskModel {
  final TaskOrderDetailModel orderDetail;
  final EvidenceModel? evidence;

  TaskWeddingModel({
    required super.id,
    required super.name,
    required super.description,
    required super.createdDate,
    required super.duedate,
    required super.taskMaster,
    required super.status,
    required super.notes,
    required this.orderDetail,
    this.evidence,
  });

  factory TaskWeddingModel.loading() {
    return TaskWeddingModel(
      id: -1,
      name: 'Đang tải...',
      description: 'Đang tải...',
      createdDate: DateTime.now(),
      duedate: DateTime.now(),
      taskMaster: TaskMasterModel.loading(),
      status: TaskProgressEnum.toDo,
      notes: [
        'Đang tải...',
        'Đang tải...',
        'Đang tải...',
      ],
      orderDetail: TaskOrderDetailModel.loading(),
    );
  }

  factory TaskWeddingModel.error() {
    return TaskWeddingModel(
      id: -1,
      name: 'Lỗi',
      description: 'Không có dữ liệu',
      createdDate: DateTime.now(),
      duedate: DateTime.now(),
      taskMaster: TaskMasterModel.error(),
      status: TaskProgressEnum.toDo,
      notes: [],
      orderDetail: TaskOrderDetailModel.error(),
    );
  }

  static List<TaskWeddingModel> loadingList() {
    return List.generate(3, (index) => TaskWeddingModel.loading());
  }

  static List<TaskWeddingModel> errorList<A, E>() {
    return List.generate(3, (index) => TaskWeddingModel.error());
  }
}
