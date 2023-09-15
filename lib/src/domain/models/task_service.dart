// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskServiceModel {
  final String name;
  final double price;
  final String unit;
  TaskServiceModel({
    required this.name,
    required this.price,
    required this.unit,
  });

  factory TaskServiceModel.loading() {
    return TaskServiceModel(
      name: 'Đang tải...',
      unit: 'Đang tải...',
      price: 0,
    );
  }

  factory TaskServiceModel.error() {
    return TaskServiceModel(
      name: 'Không có dữ liệu',
      unit: 'Không có dữ liệu',
      price: 0,
    );
  }
}
