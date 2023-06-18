import 'dart:convert';
import 'dart:math';

import 'package:mockito/mockito.dart';
import 'package:otus_course/common_tools/network/web_socket_endpoint.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/control/hard_stop_command.dart';
import 'package:otus_course/game/commands/control/start_command.dart';
import 'package:otus_course/game/commands/interpret_command.dart';
import 'package:otus_course/game/commands/macro/macro_command.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/init_ioc.dart';
import 'package:otus_course/game/separate_game_loop.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:otus_course/game/web_socket_endpoint.dart';
import 'package:otus_course/ioc.dart';
import 'package:test/test.dart';
import 'package:web_socket_client/web_socket_client.dart';

class MockICommand extends Mock implements ICommand {}

void main() {
  final incomingMessageJson = {
    'game_id': 'simple',
    'game_object_id': '548',
    'command_id': 'move',
    'args': [0, 2],
  };

  //jwt for {'user': 'user1', 'game_id': 'simple'}
  final jwt = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoidXNlcjEiLCJnYW1lX2lkIjoic2ltcGxlIiwiaWF0IjoxNjg1OTUwMzQxfQ.QMKeTMjRExl31vWgndUbhbGqXb7uhGXwUPkTVL8FDpg';

  final incomingMessageJsonWithJwt = {
    'game_id': 'simple',
    'game_object_id': '548',
    'command_id': 'move',
    'jwt': jwt,
    'args': [0, 2],
  };

  final incomingMessageJsonWithJwtAndWrongGameId = {
    'game_id': 'simple123',
    'game_object_id': '548',
    'command_id': 'move',
    'jwt': jwt,
    'args': [0, 2],
  };

  late final SeparateGameLoop commandQueue;
  late final WebSocketEndpoint endpoint;
  late final WebSocket client;

  setUpAll(() async {
    commandQueue = SeparateGameLoop();
    endpoint = GameWebSocketEndpoint();

    initIoC();
    IoC.pushNewScope(scopeName: 'test');
    IoC.get<Map<String, Map<String, String>>>(
        instanceName: 'GameCommands')['simple'] = {
      'init': 'InitVelocity',
      'move': 'Move',
    };
    IoC.get<Map<String, CommandQueue>>(instanceName: 'GameThreads')['simple'] =
        commandQueue;
    IoC.registerSingleton<String>('SecretKey', instanceName: 'SecretKey');

    final gameObject = UObject();
    gameObject.setProperty('id', '548');
    gameObject.setProperty('position', Point(0, 0));
    IoC.get<List<UObject>>(instanceName: 'GameObjects').add(gameObject);
    client = WebSocket(Uri(
      scheme: 'ws',
      host: endpoint.host,
      port: endpoint.port,
    ));
    await endpoint.start();
    StartCommand(commandQueue).execute();
    await client.connection.firstWhere((state) => state is Connected);
  });

  tearDownAll(() {
    commandQueue.putCommand(HardStopCommand(commandQueue));
    client.close();
  });

  group('web socket endpoint test', () {
    test('if client send message then get InterpretCommand and MoveCommand',
        () async {
      client.send(jsonEncode(incomingMessageJsonWithJwt));
      await expectLater(
        commandQueue.queueStreamController.stream,
        emitsInOrder([isA<InterpretCommand>(), isA<MacroCommand>()]),
      );
    });
    test('if client send message without jwt, no commands generate',
            () async {
          client.send(jsonEncode(incomingMessageJson));
          await expectLater(
            commandQueue.queueStreamController.stream,
            emitsInOrder([]),
          );
        });
    test('if client send message with jwt but wrong gameId, no commands generate',
            () async {
          client.send(jsonEncode(incomingMessageJsonWithJwtAndWrongGameId));
          await expectLater(
            commandQueue.queueStreamController.stream,
            emitsInOrder([]),
          );
        });
  });
}
