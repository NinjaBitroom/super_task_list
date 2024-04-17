import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:super_task_list/models/task_model.dart';

final class DBOperations {
  final db = Supabase.instance.client;

  Future<AuthResponse> signUp(String email, String password) async {
    return await db.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return await db.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await db.auth.signOut();
  }

  Future<void> createTask(String title) async {
    await db.from('tasks').insert({
      'title': title,
      'user': db.auth.currentUser?.id,
    });
  }

  Future<void> updateTask() async {}
  Future<void> deleteTask() async {}

  Future<List<TaskModel>> getTasks() async {
    final json = await db
        .from('tasks')
        .select()
        .eq('user', db.auth.currentUser?.id as Object);
    final tasks = <TaskModel>[];
    for (final task in json) {
      tasks.add(TaskModel.fromJson(task));
    }
    return tasks;
  }
}
