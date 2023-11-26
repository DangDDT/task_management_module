import 'get_param.dart';

class GetTaskWeddingParam extends GetParam {
  final DateTime? startDateFrom;
  final DateTime? startDateTo;
  final List<String>? status;
  final String? taskName;

  GetTaskWeddingParam({
    required super.pageIndex,
    required super.pageSize,
    required super.orderBy,
    required super.orderType,
    this.startDateFrom,
    this.startDateTo,
    this.status,
    this.taskName,
  });
}
