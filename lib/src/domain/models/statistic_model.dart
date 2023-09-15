abstract class StatisticalModel {}

class TaskWithStatusStatisticalModel extends StatisticalModel {
  final String code;
  final int value;

  TaskWithStatusStatisticalModel({
    required this.code,
    required this.value,
  });
}
