import 'package:task_management_module/src/domain/models/task_service.dart';

class TaskOrderDetailModel {
  final TaskServiceModel service;
  final int quantity;

  ///Đơn giá gốc của dịch vụ
  final double price;
  final DateTime eventDate;

  ///Phần trăm chiết khấu cho cửa hàng
  final double commission;

  final String description;

  TaskOrderDetailModel({
    required this.service,
    required this.quantity,
    required this.price,
    required this.eventDate,
    required this.commission,
    required this.description,
  });

  factory TaskOrderDetailModel.loading() {
    return TaskOrderDetailModel(
      service: TaskServiceModel.loading(),
      quantity: 0,
      price: 0,
      eventDate: DateTime.now(),
      commission: 0,
      description: 'Đang tải',
    );
  }

  factory TaskOrderDetailModel.error() {
    return TaskOrderDetailModel(
      service: TaskServiceModel.error(),
      quantity: 0,
      price: 0,
      eventDate: DateTime.now(),
      commission: 0,
      description: 'Đã có lỗi xảy ra',
    );
  }

  double get totalPrice => price * quantity;

  double get totalCommission => totalPrice * (commission / 100);

  double get revenue => totalPrice - totalCommission;

  static List<TaskOrderDetailModel> loadings() {
    return List.generate(3, (index) => TaskOrderDetailModel.loading());
  }

  static List<TaskOrderDetailModel> errors() {
    return List.generate(3, (index) => TaskOrderDetailModel.error());
  }

  @override
  String toString() {
    return 'TaskOrderDetailModel(service: $service, quantity: $quantity, price: $price, eventDate: $eventDate, commission: $commission, description: $description)';
  }
}
