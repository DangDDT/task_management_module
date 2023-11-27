// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskCategoryModel {
  final dynamic id;
  final String code;
  final String name;
  final String description;

  /// Commission rate of this service, which is used to calculate the commission
  final double? commissionRate;

  TaskCategoryModel({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    this.commissionRate,
  });

  factory TaskCategoryModel.empty() {
    return TaskCategoryModel(
      id: 0,
      code: "",
      name: "Đang tải",
      description: "",
      commissionRate: 8,
    );
  }

  @override
  bool operator ==(covariant TaskCategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.code == code &&
        other.name == name &&
        other.description == description &&
        other.commissionRate == commissionRate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        code.hashCode ^
        name.hashCode ^
        description.hashCode ^
        commissionRate.hashCode;
  }
}

class ListServiceCategoryModel {
  static List<TaskCategoryModel> get empty {
    return [
      TaskCategoryModel.empty(),
      TaskCategoryModel.empty(),
      TaskCategoryModel.empty(),
      TaskCategoryModel.empty(),
      TaskCategoryModel.empty(),
      TaskCategoryModel.empty(),
    ];
  }
}
