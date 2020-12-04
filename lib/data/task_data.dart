import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'task_data.g.dart';

@HiveType(typeId: 0)
class TaskData {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final bool isCompleted;

  @HiveField(2)
  final String currentDate;

  @HiveField(3)
  final String currentMonth;

  @HiveField(4)
  final String currentYear;

  TaskData(
      {this.title,
      this.isCompleted = false,
      this.currentDate,
      this.currentMonth,
      this.currentYear});
}

class TaskList extends ChangeNotifier {
  List<TaskData> tasksList = [];

  void addTask(String newTask, DateTime dateTime) {
    Hive.box('tasks').add(TaskData(
        title: newTask,
        currentDate: dateTime.day.toString(),
        currentMonth: dateTime.month.toString(),
        currentYear: dateTime.year.toString()));
    notifyListeners();
  }

  void deleteTask(int index) {
    Hive.box('tasks').deleteAt(index);
    notifyListeners();
  }
}
