import 'package:life_management/models/task.dart';
import 'package:riverpod/riverpod.dart';


class TaskNotifier extends StateNotifier<List<TaskModel>>{
  TaskNotifier() : super([]);

  void addTask(TaskModel task){
    state = [...state, task];
  }
}


final taskList = StateNotifierProvider<TaskNotifier,List<TaskModel>>((ref) => TaskNotifier());