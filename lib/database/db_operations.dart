import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:super_task_list/models/task_model.dart';
import 'package:super_task_list/utils/app_routes.dart';

abstract final class DBOperations {
  static final db = Supabase.instance.client;

  static Future<AuthResponse> signUp(String email, String password) async {
    return await db.auth.signUp(
      email: email,
      password: password,
    );
  }

  static Future<AuthResponse> signIn(String email, String password) async {
    return await db.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await db.auth.signOut();
  }

  static Future<void> sendPasswordResetEmail(String email) async {
    const baseURL = 'io.github.ninjabitroom://super_task_list';
    await db.auth.resetPasswordForEmail(
      email,
      redirectTo: baseURL + AppRoutes.resetPasswordPage,
    );
  }

  static Future<void> resetPassword(String newPassword) async {
    await db.auth.updateUser(UserAttributes(password: newPassword));
  }

  static Future<void> createTask(String title) async {
    await db.from('tasks').insert({
      'title': title,
      'user': db.auth.currentUser?.id,
    });
  }

  static Future<void> updateTask(int id,
      {String? newTitle, bool? newDone}) async {
    final dict = {};
    if (newTitle != null) {
      dict['title'] = newTitle;
    }
    if (newDone != null) {
      dict['done'] = newDone;
    }
    await db.from('tasks').update(dict).match({'id': id});
  }

  static Future<void> deleteTask(int id) async {
    await db.from('tasks').delete().match({'id': id});
  }

  static Future<List<TaskModel>> getTasks() async {
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
