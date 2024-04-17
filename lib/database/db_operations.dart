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

  Future<void> recoverPassword(String email) async {
    await db.auth.resetPasswordForEmail(
      email,
      redirectTo: 'io.github.ninjabitroom://super_task_list/login-callback',
    );
  }

  Future<void> createTask(String title) async {
    await db.from('tasks').insert({
      'title': title,
      'user': db.auth.currentUser?.id,
    });
  }

  Future<void> updateTask(int id, {String? newTitle, bool? newDone}) async {
    final dict = {};
    if (newTitle != null) {
      dict['title'] = newTitle;
    }
    if (newDone != null) {
      dict['done'] = newDone;
    }
    await db.from('tasks').update(dict).match({'id': id});
  }

  Future<void> deleteTask(int id) async {
    await db.from('tasks').delete().match({'id': id});
  }

  Future<List<TaskModel>> getTasks() async {
    final json = await db
        .from('tasks')
        .select()
        .eq('user', db.auth.currentUser?.id as Object)
        .order('done', ascending: true)
        .order('id', ascending: true);
    final tasks = <TaskModel>[];
    for (final task in json) {
      tasks.add(TaskModel.fromJson(task));
    }
    return tasks;
  }
}
