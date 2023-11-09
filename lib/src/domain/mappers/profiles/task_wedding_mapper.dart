import 'package:task_management_module/core/core.dart';
import 'package:task_management_module/src/domain/enums/private/task_categories_enum.dart';
import 'package:task_management_module/src/domain/models/evidence.dart';
import 'package:task_management_module/src/domain/models/task_comment.dart';
import 'package:task_management_module/src/domain/models/task_customer.dart';
import 'package:task_management_module/src/domain/models/task_model.dart';
import 'package:task_management_module/src/domain/models/task_order_detail.dart';
import 'package:task_management_module/src/domain/models/task_service.dart';
import 'package:wss_repository/entities/task.dart';

import '../../domain.dart';

class TaskWeddingMapper extends BaseDataMapperProfile<Task, TaskWeddingModel> {
  @override
  TaskWeddingModel mapData(Task entity, Mapper mapper) {
    return TaskWeddingModel(
      id: entity.id ?? DefaultValueMapperConstants.defaultStringValue,
      name: entity.taskName ?? DefaultValueMapperConstants.defaultStringValue,
      status: TaskProgressEnum.fromCode(entity.status ?? ''),

      ///Trả về list không phải là 1 object
      orderDetails: (entity.order?.orderDetails != null)
          ? [
              for (var item in entity.order!.orderDetails)
                TaskOrderDetailModel(
                  commission: 1.0,
                  quantity: 1,
                  service: TaskServiceModel(
                    name: item.service?.name ??
                        DefaultValueMapperConstants.defaultStringValue,
                    price: item.price?.toDouble() ??
                        DefaultValueMapperConstants.defaultDoubleValue,
                    description: item.description ??
                        DefaultValueMapperConstants.defaultStringValue,
                    images: item.service?.serviceImages ?? [],

                    ///Thiếu dữ liệu đơn vị tính của dịch vụ
                    unit: 'dịch vụ',
                  ),
                  price: item.price?.toDouble() ??
                      DefaultValueMapperConstants.defaultDoubleValue,
                  description: item.description ??
                      DefaultValueMapperConstants.defaultStringValue,
                  eventDate: item.startTime ??
                      DefaultValueMapperConstants.defaultDateTimeValue,
                )
            ].toList()
          : [],

      comments: entity.comments
          .map(
            (e) => TaskCommentModel(
              id: e.id ?? DefaultValueMapperConstants.defaultStringValue,
              content:
                  e.content ?? DefaultValueMapperConstants.defaultStringValue,
              createdAt: e.createDate ??
                  DefaultValueMapperConstants.defaultDateTimeValue,
              creator: TaskCommentCreatorModel(
                id: e.createBy ??
                    DefaultValueMapperConstants.defaultStringValue,

                ///Thiếu dữ liệu tên và ảnh đại diện của người tạo comment
                fullName: DefaultValueMapperConstants.defaultStringValue,
                avatar: DefaultValueMapperConstants.defaultStringValue,
              ),
            ),
          )
          .toList(),

      customer: TaskCustomerModel(
        id: entity.order?.customerId ??
            DefaultValueMapperConstants.defaultStringValue,
        address: entity.order?.customer?.address ??
            DefaultValueMapperConstants.defaultStringValue,
        avatar: DefaultValueMapperConstants.defaultStringValue,
        email: '',
        fullName: entity.order?.customer?.fullname ?? '',
        phoneNumber: entity.order?.customer?.phone ?? '',
      ),

      ///Thiếu dữ liệu thông tin bằng chứng báo cáo công việc (có thể null với các status khác)
      evidence: ImageEvidenceModel(
        evidenceValue: DefaultValueMapperConstants.defaultStringValue,
      ),

      ///Thiếu dữ liệu người tạo công việc
      taskMaster: TaskMasterModel(
        id: '${entity.createBy?.fullname}_${entity.createBy?.phone}',
        avatar: '',
        name: entity.createBy?.fullname ?? '',
        phoneNumber: entity.createBy?.phone ?? '',

        ///Thiếu dữ liệu email của người tạo công việc
        email: '',
      ),

      ///Thiếu dữ liệu thời gian tạo và thời gian hết hạn của công việc
      createdDate:
          entity.startDate ?? DefaultValueMapperConstants.defaultDateTimeValue,
      duedate:
          entity.endDate ?? DefaultValueMapperConstants.defaultDateTimeValue,

      ///Không hiển thị

      description: '',
    );
  }
}
