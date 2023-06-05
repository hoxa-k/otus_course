import 'dart:math';

import 'package:otus_course/auth_service/jwt_creator.dart';
import 'package:otus_course/auth_service/models/outgoing_message.dart';
import 'package:otus_course/ioc.dart';

class AuthController {
  final Map<String, List<String>> gameUsers = {};

  dynamic createGame(List<String>? users) {
    if (users == null) return null;
    final gameId = _generateGameId();
    gameUsers[gameId] = users;
    return OutgoingMessage(gameId: gameId).toJson();
  }

  dynamic authenticate(String? gameId, String? user) {
    final entry = gameUsers.entries.where((element) => element.value.contains(user) && element.key == gameId);

    if (entry.isNotEmpty) {
      final jwt = IoC.get<JwtCreator>().generateJwt(
          {'user': user, 'game_id': entry.first.key});
      return OutgoingMessage(gameId: entry.first.key, jwt: jwt).toJson();
    } else {
      return OutgoingMessage(error: 'User not found').toJson();
    }
  }


String _generateGameId() {
  final generatedId = Random().nextInt(2 ^ 32).toString();
  if (gameUsers.keys.contains(generatedId)) {
    return _generateGameId();
  } else {
    return generatedId;
  }
}}
