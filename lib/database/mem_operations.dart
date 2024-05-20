import 'package:super_task_list/models/client_task_model.dart';
import 'package:uuid/uuid.dart';

abstract final class MemOperations {
  static List<ClientTaskModel>? tasks;

  static ClientTaskModel createTask(String title) {
    final newTask = ClientTaskModel(
      clientId: const Uuid().v1(),
      serverId: null,
      createdAt: DateTime.now(),
      title: title,
      done: false,
    );
    tasks ??= [];
    tasks?.add(newTask);
    return newTask;
  }

  static ClientTaskModel readTask(String id) {
    return tasks!.firstWhere((element) => element.clientId == id);
  }

  static ClientTaskModel updateTask(
    String id, {
    String? newTitle,
    bool? newDone,
    int? newServerId,
  }) {
    if (newTitle == null && newDone == null && newServerId == null) {
      throw Exception('Insira pelo menos um valor para atualizar.');
    }
    final task = tasks?.firstWhere((element) => element.clientId == id);
    if (newTitle != null) {
      task?.title = newTitle;
    }
    if (newDone != null) {
      task?.done = newDone;
    }
    if (newServerId != null) {
      task?.serverId = newServerId;
    }
    return task!;
  }

  static int? deleteTask(String id) {
    final sid = tasks?.firstWhere((element) => element.clientId == id).serverId;
    tasks?.removeWhere((element) => element.clientId == id);
    return sid;
  }

  static void sortTasks() {
    tasks?.sort((a, b) => a.clientId.compareTo(b.clientId));
  }
}
