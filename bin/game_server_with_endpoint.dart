import 'dart:convert';
import 'dart:math';

import 'package:otus_course/auth_service/init_ioc.dart';
import 'package:otus_course/auth_service/web_socket_endpoint.dart';
import 'package:otus_course/game/commands/control/start_command.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/init_ioc.dart';
import 'package:otus_course/game/separate_game_loop.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:otus_course/game/web_socket_endpoint.dart';
import 'package:otus_course/ioc.dart';
import 'package:web_socket_client/web_socket_client.dart';

void main(List<String> arguments) async {
  initIoC();
  _initGameObjects();

  initAuthIoC();

  final authWebSocketEndpoint = AuthWebSocketEndpoint();
  await authWebSocketEndpoint.start();

  final gameWebSocketEndpoint = GameWebSocketEndpoint();
  await gameWebSocketEndpoint.start();

  final authClient = WebSocket(Uri(
    scheme: 'ws',
    host: authWebSocketEndpoint.host,
    port: authWebSocketEndpoint.port,
  ));

  final gameClient = WebSocket(Uri(
    scheme: 'ws',
    host: gameWebSocketEndpoint.host,
    port: gameWebSocketEndpoint.port,
  ));

  await authClient.connection.firstWhere((state) => state is Connected);
  authClient.send(jsonEncode({
    'users': ['user1', 'user2'],
    'action': 'create_game',
  }));
  final jsonAnswer = jsonDecode(await authClient.messages.first);
  final gameId = jsonAnswer['game_id'];
  _initQueue(gameId);

  authClient.send(jsonEncode({
    'user': 'user1',
    'game_id': gameId,
    'action': 'authenticate',
  }));
  final jsonAnswerAuth = jsonDecode(await authClient.messages.first);
  final jwt = jsonAnswerAuth['jwt'];

  await gameClient.connection.firstWhere((state) => state is Connected);
  final incomingMessageJsonWithoutJwt = {
    'game_id': gameId,
    'game_object_id': '548',
    'command_id': 'move',
    'args': [0, 2],
  };
  gameClient.send(jsonEncode(incomingMessageJsonWithoutJwt));
  final errorAnswer = await gameClient.messages.first;
  print('errorAnswer $errorAnswer');

  final incomingMessageJson = {
    'jwt': jwt,
    'game_id': gameId,
    'game_object_id': '548',
    'command_id': 'move',
    'args': [0, 2],
  };

  gameClient.send(jsonEncode(incomingMessageJson));

  Future.delayed(Duration(seconds: 5), () {
    gameClient.close();
    authClient.close();

    authWebSocketEndpoint.close();
    gameWebSocketEndpoint.close();
  });
}

void _initQueue(String gameId) {
  final simpleGamesCommandQueue = SeparateGameLoop();
  StartCommand(simpleGamesCommandQueue).execute();

  IoC.get<Map<String, CommandQueue>>(instanceName: 'GameThreads')[gameId] =
      simpleGamesCommandQueue;

  IoC.get<GameCommandsMap>(instanceName: 'GameCommands')[gameId] = {
    'StartMove': ['InitVelocity', 'Move'],
    'StopMove': ['StopMove'],
  };
}

void _initGameObjects() {
  final gameObject = UObject();
  gameObject.setProperty('id', '548');
  gameObject.setProperty('position', Point(0, 0));
  IoC.get<List<UObject>>(instanceName: 'GameObjects').add(gameObject);
}
