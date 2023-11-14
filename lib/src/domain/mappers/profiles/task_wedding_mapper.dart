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
      orderDetails: (entity.orderDetails.isNotEmpty)
          ? [
              for (var item in entity.orderDetails)
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
                fullName: e.createBy?.fullname ??
                    DefaultValueMapperConstants.defaultStringValue,
                avatar: e.createBy?.imageUrl ??
                    DefaultValueMapperConstants.defaultStringValue,
              ),
            ),
          )
          .toList(),

      customer: entity.orderDetails.isNotEmpty
          ? TaskCustomerModel(
              id: entity.orderDetails[0].order?.customerId ??
                  DefaultValueMapperConstants.defaultStringValue,
              address: entity.orderDetails[0].order?.address ??
                  DefaultValueMapperConstants.defaultStringValue,
              avatar: DefaultValueMapperConstants.defaultStringValue,
              email: '',
              fullName: entity.orderDetails[0].order?.customer?.fullname ??
                  DefaultValueMapperConstants.defaultStringValue,
              phoneNumber: entity.orderDetails[0].order?.customer?.phone ??
                  DefaultValueMapperConstants.defaultStringValue,
            )
          : TaskCustomerModel(
              id: 'Không có dữ liệu',
              address: 'Không có dữ liệu',
              avatar: 'Không có dữ liệu',
              email: 'Không có dữ liệu',
              fullName: 'Không có dữ liệu',
              phoneNumber: 'Không có dữ liệu',
            ),

      evidence: entity.imageEvidence != null
          ? ImageEvidenceModel(evidenceValue: entity.imageEvidence!)
          : null,

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
      createdDate: DefaultValueMapperConstants.defaultDateTimeValue,
      duedate:
          entity.startDate ?? DefaultValueMapperConstants.defaultDateTimeValue,

      ///Không hiển thị

      description: '',
    );
  }
}
