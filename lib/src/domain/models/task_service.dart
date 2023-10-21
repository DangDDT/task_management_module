// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskServiceModel {
  final String name;
  final String description;
  final double price;
  final String unit;
  final List<String> images;
  TaskServiceModel({
    required this.name,
    required this.description,
    required this.price,
    required this.unit,
    required this.images,
  });

  factory TaskServiceModel.loading() {
    return TaskServiceModel(
      name: 'Đang tải...',
      description: 'Đang tải...',
      unit: 'Đang tải...',
      price: 0,
      images: [],
    );
  }

  factory TaskServiceModel.error() {
    return TaskServiceModel(
      name: 'Không có dữ liệu',
      description: 'Không có dữ liệu',
      unit: 'Không có dữ liệu',
      price: 0,
      images: [],
    );
  }
}
