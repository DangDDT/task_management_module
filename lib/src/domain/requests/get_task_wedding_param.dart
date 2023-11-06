import 'get_param.dart';

class GetTaskWeddingParam extends GetParam {
  final DateTime? dueDateFrom;
  final DateTime? dueDateTo;
  final List<String>? status;
  final String? taskName;

  GetTaskWeddingParam({
    required super.pageIndex,
    required super.pageSize,
    required super.orderBy,
    required super.orderType,
    this.dueDateFrom,
    this.dueDateTo,
    this.status,
    this.taskName,
  });
}
