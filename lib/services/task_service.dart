import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/task_model.dart';

abstract final class TaskService {
  static List<TaskModel>? tasks;

  static List<TaskModel>? get pendingTasks =>
      tasks?.where((element) => !element.done).toList();

  static List<TaskModel>? get completedTasks =>
      tasks?.where((element) => element.done).toList();

  static Future<TaskModel> createTask(String title) async {
    final newTask = await DBOperations.createTask(title);
    tasks?.add(newTask);
    return newTask;
  }

  static Future<TaskModel> updateTask(
    int id, {
    String? newTitle,
    bool? newDone,
  }) async {
    if (newTitle == null && newDone == null) {
      throw Exception('Insira pelo menos o título ou o status da tarefa!');
    }
    final task = tasks?.firstWhere((element) => element.id == id);
    if (newTitle != null) {
      task?.title = newTitle;
    }
    if (newDone != null) {
      task?.done = newDone;
    }
    return await DBOperations.updateTask(
      task!.id,
      newTitle: newTitle,
    );
  }

  static Future<void> deleteTask(int id) async {
    tasks?.removeWhere((element) => element.id == id);
    await DBOperations.deleteTask(id);
  }
}
