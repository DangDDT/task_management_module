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
      orderDetail: TaskOrderDetailModel(
        commission: 1.0,
        quantity: 1,
        fullName: entity.orderDetail?.order?.fullname ??
            DefaultValueMapperConstants.defaultStringValue,
        address: entity.orderDetail?.order?.address ??
            DefaultValueMapperConstants.defaultStringValue,
        phone: entity.orderDetail?.order?.phone ??
            DefaultValueMapperConstants.defaultStringValue,
        service: TaskServiceModel(
          name: entity.orderDetail?.service?.name ??
              DefaultValueMapperConstants.defaultStringValue,
          price: entity.orderDetail?.price?.toDouble() ??
              DefaultValueMapperConstants.defaultDoubleValue,
          description: entity.orderDetail?.service?.description ??
              DefaultValueMapperConstants.defaultStringValue,
          images: (entity.orderDetail?.service?.serviceImages ?? [])
              .map((e) => e.imageUrl ?? '')
              .toList(),
          unit: entity.orderDetail?.service?.unit ??
              DefaultValueMapperConstants.defaultStringValue,
        ),
        price: entity.orderDetail?.price?.toDouble() ??
            DefaultValueMapperConstants.defaultDoubleValue,
        description: entity.orderDetail?.description ??
            DefaultValueMapperConstants.defaultStringValue,
        eventDate: entity.orderDetail?.startTime ??
            DefaultValueMapperConstants.defaultDateTimeValue,
      ),
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
      customer: entity.orderDetail?.order?.customer != null
          ? TaskCustomerModel(
              id: entity.orderDetail?.order?.customer?.idNavigation?.id ??
                  DefaultValueMapperConstants.defaultStringValue,
              address: entity.orderDetail?.order?.customer?.address ??
                  DefaultValueMapperConstants.defaultStringValue,
              avatar: entity.orderDetail?.order?.customer?.imageUrl ??
                  DefaultValueMapperConstants.defaultStringValue,
              email:
                  entity.orderDetail?.order?.customer?.idNavigation?.username ??
                      DefaultValueMapperConstants.defaultStringValue,
              fullName: entity.orderDetail?.order?.customer?.fullname ??
                  DefaultValueMapperConstants.defaultStringValue,
              phoneNumber: entity.orderDetail?.order?.customer?.phone ??
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
      taskMaster: TaskMasterModel(
        id: '${entity.createBy?.fullname}_${entity.createBy?.phone}',
        avatar: '',
        name: entity.createBy?.fullname ?? '',
        phoneNumber: entity.createBy?.phone ?? '',
        email: '',
      ),
      createdDate:
          entity.createDate ?? DefaultValueMapperConstants.defaultDateTimeValue,
      duedate:
          entity.startDate ?? DefaultValueMapperConstants.defaultDateTimeValue,
      description: '',
    );
  }
}
