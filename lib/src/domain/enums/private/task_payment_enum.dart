import 'package:flutter/material.dart';

import '../../../../core/constants/ui_constant.dart';

enum TaskPaymentEnum {
  all('Tất cả'),
  paid('Đã thanh toán'),
  notPaid('Chưa thanh toán');

  final String name;

  const TaskPaymentEnum(this.name);

  bool get isPaid => this == TaskPaymentEnum.paid;

  bool get isNotPaid => this == TaskPaymentEnum.notPaid;

  static TaskPaymentEnum? fromCode(bool? code) {
    switch (code) {
      case true:
        return TaskPaymentEnum.paid;
      case false:
        return TaskPaymentEnum.notPaid;
      default:
        return TaskPaymentEnum.all;
    }
  }

  bool? toCode() {
    switch (this) {
      case TaskPaymentEnum.paid:
        return true;
      case TaskPaymentEnum.notPaid:
        return false;
      default:
        return null;
    }
  }

  TaskPaymentEnum get next {
    switch (this) {
      case TaskPaymentEnum.all:
        return TaskPaymentEnum.paid;
      case TaskPaymentEnum.paid:
        return TaskPaymentEnum.notPaid;
      case TaskPaymentEnum.notPaid:
        return TaskPaymentEnum.all;
    }
  }

  Color get color {
    switch (this) {
      case TaskPaymentEnum.all:
        return kTheme.colorScheme.primary;
      case TaskPaymentEnum.paid:
        return Colors.green;
      case TaskPaymentEnum.notPaid:
        return Colors.red;
    }
  }
}
