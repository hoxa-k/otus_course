class IncomingMessage {
  final int gameId;
  final int gameObjectId;
  final String commandId;
  final dynamic? args;

  IncomingMessage({
    required this.gameId,
    required this.gameObjectId,
    required this.commandId,
    this.args,
  });

  factory IncomingMessage.fromJson(Map<String, dynamic> json) {
    return IncomingMessage(
      gameId: json['game_id'],
      gameObjectId: json['game_object_id'],
      commandId: json['command_id'],
      args: json['args'],
    );
  }
}
