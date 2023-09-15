class TaskPartnerModel {
  final dynamic id;
  final String fullName;
  final String avatar;
  final String address;
  final String email;
  final String phoneNumber;
  final Business business;

  TaskPartnerModel({
    required this.id,
    required this.fullName,
    required this.address,
    required this.avatar,
    required this.email,
    required this.phoneNumber,
    required this.business,
  });

  factory TaskPartnerModel.loading() {
    return TaskPartnerModel(
      id: -1,
      fullName: 'Đang tải...',
      avatar: 'Đang tải...',
      email: 'Đang tải...',
      phoneNumber: 'Đang tải...',
      address: 'Đang tải...',
      business: Business.loading(),
    );
  }

  factory TaskPartnerModel.error() {
    return TaskPartnerModel(
      id: -1,
      fullName: 'Không có dữ liệu',
      avatar: 'Không có dữ liệu',
      email: 'Không có dữ liệu',
      phoneNumber: 'Không có dữ liệu',
      address: 'Không có dữ liệu',
      business: Business.error(),
    );
  }
}

class Business {
  final dynamic id;
  final String name;

  Business({
    required this.id,
    required this.name,
  });

  factory Business.loading() {
    return Business(
      id: -1,
      name: 'Đang tải...',
    );
  }

  factory Business.error() {
    return Business(
      id: -1,
      name: 'Không có dữ liệu',
    );
  }
}
