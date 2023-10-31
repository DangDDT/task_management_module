class TaskCustomerModel {
  final dynamic id;
  final String fullName;
  final String avatar;
  final String email;
  final String phoneNumber;
  final String address;

  TaskCustomerModel({
    required this.id,
    required this.fullName,
    required this.avatar,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  factory TaskCustomerModel.loading() {
    return TaskCustomerModel(
      id: -1,
      fullName: 'Đang tải...',
      avatar: 'Đang tải...',
      email: 'Đang tải',
      phoneNumber: 'Đang tải...',
      address: 'Đang tải...',
    );
  }

  factory TaskCustomerModel.error() {
    return TaskCustomerModel(
      id: -1,
      fullName: 'Không có dữ liệu',
      avatar: 'Không có dữ liệu',
      email: 'Không có dữ liệu',
      phoneNumber: 'Không có dữ liệu',
      address: 'Không có dữ liệu',
    );
  }

  @override
  String toString() {
    return 'TaskCustomerModel(id: $id, fullName: $fullName, avatar: $avatar, email: $email, phoneNumber: $phoneNumber, address: $address)';
  }
}
