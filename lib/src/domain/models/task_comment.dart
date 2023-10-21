class TaskCommentModel {
  final dynamic id;
  final String content;
  final DateTime createdAt;
  final TaskCommentCreatorModel creator;

  TaskCommentModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.creator,
  });

  factory TaskCommentModel.loading() {
    return TaskCommentModel(
      id: -1,
      content: 'Đang tải...',
      createdAt: DateTime.now(),
      creator: TaskCommentCreatorModel.loading(),
    );
  }

  factory TaskCommentModel.error() {
    return TaskCommentModel(
      id: -1,
      content: 'Không có dữ liệu',
      createdAt: DateTime.now(),
      creator: TaskCommentCreatorModel.error(),
    );
  }

  static List<TaskCommentModel> loadings() {
    return List.generate(3, (index) => TaskCommentModel.loading());
  }

  static List<TaskCommentModel> errors() {
    return List.generate(3, (index) => TaskCommentModel.error());
  }
}

class TaskCommentCreatorModel {
  final dynamic id;
  final String fullName;
  final String avatar;

  TaskCommentCreatorModel({
    required this.id,
    required this.fullName,
    required this.avatar,
  });

  factory TaskCommentCreatorModel.loading() {
    return TaskCommentCreatorModel(
      id: -1,
      fullName: 'Đang tải...',
      avatar: 'Đang tải...',
    );
  }

  factory TaskCommentCreatorModel.error() {
    return TaskCommentCreatorModel(
      id: -1,
      fullName: 'Không có dữ liệu',
      avatar: 'Không có dữ liệu',
    );
  }
}
