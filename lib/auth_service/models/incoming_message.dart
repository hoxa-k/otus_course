class IncomingMessage {
  final String? gameId;
  final String? user;
  final List<String>? users;
  final String? action;

  IncomingMessage({
    this.gameId,
    this.users,
    this.action,
    this.user,
  });

  factory IncomingMessage.fromJson(Map<String, dynamic> json) {
    return IncomingMessage(
      gameId: json['game_id'],
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      action: json['action'],
      user: json['user'],
    );
  }
}
