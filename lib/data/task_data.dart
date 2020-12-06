import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'task_data.g.dart';

@HiveType(typeId: 0)
class TaskData {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  @HiveField(2)
  String currentDate;

  @HiveField(3)
  String currentMonth;

  @HiveField(4)
  String currentYear;

  TaskData(
      {this.title,
      this.isCompleted = false,
      this.currentDate,
      this.currentMonth,
      this.currentYear});
}

class TaskList extends ChangeNotifier {
  List<TaskData> _tasksList = [];

  UnmodifiableListView get tasksList => UnmodifiableListView(_tasksList);

  void addTask(String newTask, DateTime dateTime) {
    final task = TaskData(
        title: newTask,
        currentDate: dateTime.day.toString(),
        currentMonth: dateTime.month.toString(),
        currentYear: dateTime.year.toString());
    _tasksList.add(task);
    Hive.box('tasks').add(task);
    notifyListeners();
  }

  void deleteTask(int index) {
    Hive.box('tasks').deleteAt(index);
    _tasksList.removeAt(index);
    notifyListeners();
  }

  void updateTask(int index,TaskData task){
    _tasksList[index] = task;
    Hive.box('tasks').putAt(index, task);
    notifyListeners();
  }

  void toggleTask(int index){
    _tasksList[index].isCompleted = !_tasksList[index].isCompleted;
    Hive.box('tasks').putAt(index, _tasksList[index]);
    notifyListeners();
  }

  void setTaskList(List<TaskData> list){
    _tasksList = list;
  }
}
