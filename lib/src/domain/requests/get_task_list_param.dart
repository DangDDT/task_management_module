import 'package:task_management_module/src/domain/requests/paging_param.dart';

class GetTaskListParam extends PagingQueryParam {
  final DateTime? duedateFrom;
  final DateTime? duedateTo;

  final List<String>? taskStatusCodes;
  final bool? paymentStatusCode;

  GetTaskListParam({
    required super.pageSize,
    required super.pageIndex,
    super.searchKey,
    this.duedateFrom,
    this.duedateTo,
    this.taskStatusCodes,
    this.paymentStatusCode,
  });
}
