final class TaskModel {
  final int id;
  final DateTime createdAt;
  String title;
  bool done;
  final String user;

  TaskModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.done,
    required this.user,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    final int id = json['id'];
    final DateTime createdAt = DateTime.parse(json['created_at']);
    final String title = json['title'];
    final bool done = json['done'];
    final String user = json['user'];

    return TaskModel(
      id: id,
      createdAt: createdAt,
      title: title,
      done: done,
      user: user,
    );
  }
}
