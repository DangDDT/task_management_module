// import 'package:faker/faker.dart';
// import 'package:task_management_module/src/domain/models/task_comment.dart';
// import 'package:task_management_module/src/domain/models/task_model.dart';
// import 'package:task_management_module/src/domain/models/task_progress_model.dart';

// import '../enums/private/task_categories_enum.dart';
// import '../requests/get_task_list_param.dart';

// class Dummy {
//   // static List<TaskWeddingModel> taskModel = dummyTaskModel();

//   static List<TaskProgressModel> dummyTaskProgress() {
//     Faker faker = Faker();
//     return [
//       TaskProgressModel(
//         id: 1,
//         code: 'TO_DO',
//         name: 'Mới',
//         description: 'Công việc bạn mới nhận được',
//         type: TaskProgressEnum.toDo,
//         value: faker.randomGenerator.integer(100),
//       ),
//       TaskProgressModel(
//         id: 2,
//         code: 'IN_PROGRESS',
//         name: 'Đang thực hiện',
//         description: 'Công việc mà bạn đang thực hiện',
//         type: TaskProgressEnum.inProgress,
//         value: faker.randomGenerator.integer(100),
//       ),
//       TaskProgressModel(
//         id: 3,
//         code: 'DONE',
//         name: 'Đã hoàn thành',
//         description: 'Công việc đã hoàn thành',
//         type: TaskProgressEnum.done,
//         value: faker.randomGenerator.integer(100),
//       ),
//     ];
//   }

//   // static List<TaskWeddingModel> dummyTaskModel() {
//   //   Faker faker = Faker();
//   //   final taskMaster = TaskMasterModel(
//   //     id: 1,
//   //     name: 'Đào Thị Cẩm Vân',
//   //     avatar: faker.image.image(random: true),
//   //     description: faker.lorem.sentence(),
//   //     phoneNumber: '0918172811',
//   //     email: faker.internet.email(),
//   //   );
//   //   final taskMasterComment = TaskCommentCreatorModel(
//   //     id: taskMaster.id,
//   //     fullName: taskMaster.name,
//   //     avatar: taskMaster.avatar,
//   //   );

//   //   final meComment = TaskCommentCreatorModel(
//   //     id: 1,
//   //     fullName: 'Nguyễn Văn A',
//   //     avatar: faker.image.image(random: true),
//   //   );

//   //   final taskCommentsCreator = [taskMasterComment, meComment];

//   //   final commission = faker.randomGenerator.integer(100).toDouble() / 100;

//   //   return List.generate(100, (index) {
//   //     final createdDate = DateTime.now()
//   //         .subtract(Duration(days: faker.randomGenerator.integer(min: 0, 7)));
//   //     final deadline = createdDate
//   //         .add(Duration(days: faker.randomGenerator.integer(min: 3, 30)));

//   //     return TaskWeddingModel(
//   //       id: index,
//   //       name: nameTask,
//   //       description: faker.lorem.sentence(),
//   //       createdDate: createdDate,
//   //       duedate: deadline,
//   //       taskMaster: null,
//   //       status: TaskProgressEnum.mockRandom,
//   //       orderDetails: List.generate(
//   //         faker.randomGenerator.integer(min: 1, 5),
//   //         (index) => taskOrderDetails(deadline, commission: commission),
//   //       ),
//   //       comments: List.generate(
//   //         faker.randomGenerator.integer(min: 5, 10),
//   //         (index) => TaskCommentModel(
//   //           id: faker.randomGenerator.integer(100),
//   //           content: faker.lorem.sentence(),
//   //           createdAt: DateTime.now().subtract(
//   //             Duration(days: faker.randomGenerator.integer(min: 0, 7)),
//   //           ),
//   //           creator: taskCommentsCreator[faker.randomGenerator.integer(
//   //             min: 0,
//   //             taskCommentsCreator.length,
//   //           )],
//   //         ),
//   //       ),
//   //       customer: TaskCustomerModel(
//   //         id: faker.randomGenerator.integer(100),
//   //         fullName: faker.person.name(),
//   //         avatar: faker.image.image(random: true),
//   //         email: faker.internet.email(),
//   //         phoneNumber: '0918172811',
//   //         address: faker.address.streetAddress(),
//   //       ),
//   //     );
//   //   });
//   // }

//   // static TaskOrderDetailModel taskOrderDetails(DateTime deadline,
//   //     {double commission = 0.1}) {
//   //   final TaskServiceModel taskServiceModel = TaskServiceModel(
//   //     name: nameService,
//   //     images: List.generate(
//   //       faker.randomGenerator.integer(8, min: 8),
//   //       (index) => faker.image.image(random: true),
//   //     ),
//   //     description: faker.lorem.sentence(),
//   //     price: faker.randomGenerator.integer(1000000).toDouble(),
//   //     unit: '1 chiếc',
//   //   );
//   //   const quantity = 1;
//   //   final price = taskServiceModel.price * quantity;
//   //   return TaskOrderDetailModel(
//   //     service: taskServiceModel,
//   //     quantity: quantity,
//   //     price: price,
//   //     eventDate: deadline
//   //         .add(Duration(days: faker.randomGenerator.integer(min: 7, 30))),
//   //     commission: commission,
//   //     description: faker.lorem.sentence(),
//   //   );
//   // }

//   static List<String> nameCars = [
//     "Toyota Vios",
//     "Toyota Camry",
//     "Toyota Fortuner",
//     "Toyota Innova",
//     "Chevolet Cruze",
//     "Chevolet Captiva",
//     "Chevolet Spark",
//     "Ford Ranger",
//     "Ford Everest",
//     "Ford Focus",
//     "Ford Fiesta",
//   ];

//   static List<String> numberOfSeats = [
//     "4 chỗ",
//     "5 chỗ",
//     "7 chỗ",
//     "16 chỗ",
//   ];

//   static List<String> nameGrooms = [
//     "Nguyễn Văn Thành",
//     "Trần Văn Thuỵ",
//     "Nguyễn Văn Hùng",
//     "Nguyễn Văn Hải",
//     "Nguyễn Văn Hào",
//     "Nguyễn Văn Huy",
//     "Nguyễn Văn Hưng",
//   ];

//   static List<String> nameBrides = [
//     "Nguyễn Thị Thanh",
//     "Trần Thị Thuỵ",
//     "Nguyễn Thị Hương",
//     "Nguyễn Thị Hoa",
//     "Nguyễn Thị My",
//     "Nguyễn Thị Hà",
//     "Nguyễn Thị Huyền",
//   ];

//   static String get nameTask {
//     final nameGroom =
//         nameGrooms[faker.randomGenerator.integer(nameGrooms.length, min: 0)];
//     final nameBride =
//         nameBrides[faker.randomGenerator.integer(nameBrides.length, min: 0)];
//     return 'Cung cấp xe cho đám cưới của $nameGroom & $nameBride';
//   }

//   static String get nameService {
//     final nameCar =
//         nameCars[faker.randomGenerator.integer(nameCars.length, min: 0)];
//     final numberOfSeat = numberOfSeats[
//         faker.randomGenerator.integer(numberOfSeats.length, min: 0)];
//     return '$nameCar $numberOfSeat';
//   }

//   static TaskWeddingModel dummyTaskDetailById(dynamic id) {
//     final list = taskModel;
//     return list.firstWhere((element) => element.id == id);
//   }

//   static List<TaskWeddingModel> getDummyTasks(GetTaskListParam param) {
//     return taskModel
//         .where((task) {
//           final searchStringCondition = param.searchKey != null
//               ? task.name.contains(param.searchKey!)
//               : true;
//           final dueDateCondition =
//               param.duedateFrom != null && param.duedateTo != null
//                   ? task.duedate.isAfter(param.duedateFrom!) &&
//                       task.duedate.isBefore(param.duedateTo!)
//                   : true;
//           var statusCondition = true;

//           if (param.taskStatusCodes != null) {
//             if (param.taskStatusCodes!
//                 .contains(TaskProgressEnum.all.toCode())) {
//               statusCondition = true;
//             } else {
//               statusCondition = param.taskStatusCodes!
//                   .contains(task.status.toCode().toUpperCase());
//             }
//           }

//           var paymentStatusCodeCondition = true;

//           return searchStringCondition &&
//               dueDateCondition &&
//               statusCondition &&
//               paymentStatusCodeCondition;
//         })
//         .skip(param.pageSize * param.pageIndex)
//         .take(param.pageSize)
//         .toList();
//   }

//   static List<TaskCommentModel> dummyTaskComments(dynamic taskId) {
//     return taskModel
//         .firstWhere((element) => element.id == taskId)
//         .comments
//         .map((e) => TaskCommentModel(
//               id: e.id,
//               content: e.content,
//               createdAt: e.createdAt,
//               creator: TaskCommentCreatorModel(
//                 id: e.creator.id,
//                 fullName: e.creator.fullName,
//                 avatar: e.creator.avatar,
//               ),
//             ))
//         .toList();
//   }
// }
