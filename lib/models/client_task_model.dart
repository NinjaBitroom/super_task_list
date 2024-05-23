final class ClientTaskModel {
  final String clientId;
  int? serverId;
  final DateTime createdAt;
  String title;
  bool done;

  ClientTaskModel({
    required this.clientId,
    this.serverId,
    required this.createdAt,
    required this.title,
    required this.done,
  });
}
