import 'package:life_management/models/task.dart';
import 'package:riverpod/riverpod.dart';


class TaskNotifier extends StateNotifier{
  TaskNotifier() : super([]);

  void addTask(TaskModel task){
    state = [...state, task];
  }
}


final taskList = StateNotifierProvider((ref) => TaskNotifier());