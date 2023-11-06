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
      createdDate:
          entity.startDate ?? DefaultValueMapperConstants.defaultDateTimeValue,
      duedate:
          entity.endDate ?? DefaultValueMapperConstants.defaultDateTimeValue,

      ///Trả về list không phải là 1 object
      orderDetails: [
        TaskOrderDetailModel(
          commission: 1.0,
          quantity: 1,
          service: TaskServiceModel(
            name: entity.orderDetail?.service?.name ??
                DefaultValueMapperConstants.defaultStringValue,

            ///Tạm thời map bằng giá với orderDetail do quantity = 1
            price: entity.orderDetail?.price?.toDouble() ??
                DefaultValueMapperConstants.defaultDoubleValue,
            description: entity.orderDetail?.description ??
                DefaultValueMapperConstants.defaultStringValue,
            images: entity.orderDetail?.service?.serviceImages ?? [],

            ///Thiếu dữ liệu đơn vị tính của service
            unit: DefaultValueMapperConstants.defaultStringValue,
          ),

          price: entity.orderDetail?.price?.toDouble() ??
              DefaultValueMapperConstants.defaultDoubleValue,
          description: entity.orderDetail?.description ??
              DefaultValueMapperConstants.defaultStringValue,

          ///Thiếu dữ liệu ngày diễn ra sự kiện
          eventDate: entity.orderDetail?.startTime ??
              DefaultValueMapperConstants.defaultDateTimeValue,
        )
      ].toList(),

      comments: entity.comments
              ?.map(
                (e) => TaskCommentModel(
                  id: e.id ?? DefaultValueMapperConstants.defaultStringValue,
                  content: e.content ??
                      DefaultValueMapperConstants.defaultStringValue,
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
              .toList() ??
          [],

      ///Thiếu dữ liệu thông tin khách hàng
      customer: TaskCustomerModel(
        id: DefaultValueMapperConstants.defaultStringValue,
        address: DefaultValueMapperConstants.defaultStringValue,
        avatar: DefaultValueMapperConstants.defaultStringValue,
        email: DefaultValueMapperConstants.defaultStringValue,
        fullName: DefaultValueMapperConstants.defaultStringValue,
        phoneNumber: DefaultValueMapperConstants.defaultStringValue,
      ),

      ///Thiếu dữ liệu thông tin bằng chứng báo cáo công việc (có thể null với các status khác)
      evidence: ImageEvidenceModel(
        evidenceValue: DefaultValueMapperConstants.defaultStringValue,
      ),

      ///Thiếu dữ liệu người tạo công việc
      taskMaster: TaskMasterModel(
        id: DefaultValueMapperConstants.defaultStringValue,
        avatar: DefaultValueMapperConstants.defaultStringValue,
        name: DefaultValueMapperConstants.defaultStringValue,
        email: DefaultValueMapperConstants.defaultStringValue,
        phoneNumber: DefaultValueMapperConstants.defaultStringValue,
      ),

      ///Không hiển thị

      description: '',
    );
  }
}
