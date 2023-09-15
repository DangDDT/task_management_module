import 'package:task_management_module/src/domain/models/task_customer.dart';
import 'package:task_management_module/src/domain/models/task_partner.dart';
import 'package:task_management_module/src/domain/models/task_service.dart';

class TaskOrderDetailModel {
  final TaskServiceModel service;
  final int quantity;
  final double price;
  final TaskCustomerModel customer;
  final TaskPartnerModel partner;
  final DateTime eventDate;

  TaskOrderDetailModel({
    required this.service,
    required this.quantity,
    required this.price,
    required this.customer,
    required this.partner,
    required this.eventDate,
  });

  factory TaskOrderDetailModel.loading() {
    return TaskOrderDetailModel(
      service: TaskServiceModel.loading(),
      quantity: 0,
      price: 0,
      customer: TaskCustomerModel.loading(),
      partner: TaskPartnerModel.loading(),
      eventDate: DateTime.now(),
    );
  }

  factory TaskOrderDetailModel.error() {
    return TaskOrderDetailModel(
      service: TaskServiceModel.error(),
      quantity: 0,
      price: 0,
      customer: TaskCustomerModel.error(),
      partner: TaskPartnerModel.error(),
      eventDate: DateTime.now(),
    );
  }
}
