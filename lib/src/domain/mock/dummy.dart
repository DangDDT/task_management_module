import 'package:faker/faker.dart';
import 'package:task_management_module/src/domain/models/task_customer.dart';
import 'package:task_management_module/src/domain/models/task_model.dart';
import 'package:task_management_module/src/domain/models/task_order_detail.dart';
import 'package:task_management_module/src/domain/models/task_partner.dart';
import 'package:task_management_module/src/domain/models/task_progress_model.dart';
import 'package:task_management_module/src/domain/models/task_service.dart';

import '../enums/private/task_categories_enum.dart';

class Dummy {
  static List<TaskWeddingModel> taskModel = dummyTaskModel();

  static List<TaskProgressModel> dummyTaskProgress() {
    Faker faker = Faker();
    return [
      TaskProgressModel(
        id: 1,
        code: 'TO_DO',
        name: 'Mới',
        description: 'Công việc bạn mới nhận được',
        type: TaskProgressEnum.toDo,
        value: faker.randomGenerator.integer(100),
      ),
      TaskProgressModel(
        id: 2,
        code: 'IN_PROGRESS',
        name: 'Đang thực hiện',
        description: 'Công việc mà bạn đang thực hiện',
        type: TaskProgressEnum.inProgress,
        value: faker.randomGenerator.integer(100),
      ),
      TaskProgressModel(
        id: 3,
        code: 'DONE',
        name: 'Đã hoàn thành',
        description: 'Công việc đã hoàn thành',
        type: TaskProgressEnum.done,
        value: faker.randomGenerator.integer(100),
      ),
    ];
  }

  static List<TaskWeddingModel> dummyTaskModel() {
    Faker faker = Faker();
    final taskMaster = TaskMasterModel(
      id: 1,
      name: 'Đào Thị Cẩm Vân',
      avatar: faker.image.image(random: true),
      description: faker.lorem.sentence(),
    );

    return List.generate(3, (index) {
      final createdDate = DateTime.now();
      final deadline = createdDate
          .add(Duration(days: faker.randomGenerator.integer(min: 3, 30)));
      final TaskServiceModel taskServiceModel = TaskServiceModel(
        name: 'Dịch vụ ${index + 1}',
        price: faker.randomGenerator.integer(1000000).toDouble(),
        unit: 'gói',
      );
      final quantity = faker.randomGenerator.integer(min: 1, 5);
      final price = taskServiceModel.price * quantity;
      return TaskWeddingModel(
        id: index,
        name: 'Công việc ${index + 1}',
        description: faker.lorem.sentence(),
        createdDate: createdDate,
        duedate: deadline,
        taskMaster: taskMaster,
        status: TaskProgressEnum.inProgress,
        orderDetail: TaskOrderDetailModel(
          service: taskServiceModel,
          quantity: quantity,
          price: price,
          eventDate: deadline
              .add(Duration(days: faker.randomGenerator.integer(min: 7, 30))),
          customer: TaskCustomerModel(
            id: faker.randomGenerator.integer(100),
            fullName: faker.person.name(),
            avatar: faker.image.image(random: true),
            email: faker.internet.email(),
            phoneNumber: '0918172811',
            address: faker.address.streetAddress(),
          ),
          partner: TaskPartnerModel(
            id: faker.randomGenerator.integer(100),
            fullName: faker.person.name(),
            avatar: faker.image.image(random: true),
            email: faker.internet.email(),
            phoneNumber: '0912722182',
            business: Business(
              id: faker.randomGenerator.integer(100),
              name: faker.company.name(),
            ),
            address: faker.address.streetAddress(),
          ),
        ),
        notes: faker.lorem.sentences(5),
      );
    });
  }

  static TaskWeddingModel dummyTaskDetailById(dynamic id) {
    final list = taskModel;
    return list.firstWhere((element) => element.id == id);
  }
}
