// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';
import 'package:task_management_module/src/domain/models/task_comment.dart';
import 'package:uuid/v4.dart';

import 'evidence.dart';
import 'task_customer.dart';
import 'task_order_detail.dart';

class BaseTaskModel {
  final dynamic id;
  final String code;
  final String name;
  final String description;
  final DateTime createdDate;
  final DateTime duedate;
  final TaskMasterModel? taskMaster;
  final TaskProgressEnum status;
  final List<TaskCommentModel> comments;

  BaseTaskModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.createdDate,
    required this.duedate,
    required this.taskMaster,
    required this.status,
    required this.comments,
  });
}

class TaskMasterModel {
  final dynamic id;
  final String avatar;
  final String name;
  final String phoneNumber;
  final String email;
  final String? description;
  final Map<String, dynamic>? refData;
  TaskMasterModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.phoneNumber,
    required this.email,
    this.description,
    this.refData,
  });

  factory TaskMasterModel.loading() {
    return TaskMasterModel(
      id: -1,
      name: 'Đang tải...',
      avatar: 'Đang tải...',
      phoneNumber: 'Đang tải...',
      email: 'Đang tải...',
    );
  }

  factory TaskMasterModel.error() {
    return TaskMasterModel(
      id: -1,
      name: 'Không có dữ liệu',
      avatar: 'Không có dữ liệu',
      phoneNumber: 'Không có dữ liệu',
      email: 'Không có dữ liệu',
    );
  }
}

class TaskWeddingModel extends BaseTaskModel {
  final TaskOrderDetailModel orderDetail;
  final TaskCustomerModel customer;
  final EvidenceModel? evidence;

  TaskWeddingModel({
    required super.id,
    required super.code,
    required super.name,
    required super.description,
    required super.createdDate,
    required super.duedate,
    required super.taskMaster,
    required super.status,
    required super.comments,
    required this.orderDetail,
    required this.customer,
    this.evidence,
  });

  TaskWeddingModel copyWithComment(List<TaskCommentModel> newComments) {
    return TaskWeddingModel(
      id: id,
      code: code,
      name: name,
      description: description,
      createdDate: createdDate,
      duedate: duedate,
      taskMaster: taskMaster,
      status: status,
      comments: newComments.isEmpty ? comments : newComments,
      orderDetail: orderDetail,
      customer: customer,
      evidence: evidence,
    );
  }

  factory TaskWeddingModel.loading() {
    return TaskWeddingModel(
      id: const UuidV4().generate(),
      code: 'P000000',
      name: 'Đang tải...',
      description: 'Đang tải...',
      createdDate: DateTime.now(),
      duedate: DateTime.now(),
      taskMaster: TaskMasterModel.loading(),
      status: TaskProgressEnum.toDo,
      comments: TaskCommentModel.loadings(),
      orderDetail: TaskOrderDetailModel.loading(),
      customer: TaskCustomerModel.loading(),
    );
  }

  factory TaskWeddingModel.error() {
    return TaskWeddingModel(
      id: const UuidV4().generate(),
      code: '-P999999',
      name: 'Lỗi',
      description: 'Không có dữ liệu',
      createdDate: DateTime.now(),
      duedate: DateTime.now(),
      taskMaster: TaskMasterModel.error(),
      status: TaskProgressEnum.toDo,
      comments: TaskCommentModel.errors(),
      orderDetail: TaskOrderDetailModel.error(),
      customer: TaskCustomerModel.error(),
    );
  }

  static List<TaskWeddingModel> loadingList() {
    return List.generate(3, (index) => TaskWeddingModel.loading());
  }

  static List<TaskWeddingModel> errorList<A, E>() {
    return List.generate(3, (index) => TaskWeddingModel.error());
  }

  @override
  String toString() {
    return 'TaskWeddingModel(id: $id, name: $name, description: $description, createdDate: $createdDate, duedate: $duedate, taskMaster: $taskMaster, status: $status, comments: $comments, orderDetail: $orderDetail, customer: $customer, evidence: $evidence)';
  }
}
