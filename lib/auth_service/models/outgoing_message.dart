class OutgoingMessage {
  final String? gameId;
  final String? jwt;
  final String? error;

  OutgoingMessage({
    this.gameId,
    this.jwt,
    this.error,
  });

  Map<String, dynamic> toJson() {
    return {'game_id': gameId, 'jwt': jwt, 'error': error};
  }
}
