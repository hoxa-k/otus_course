import 'dart:convert';
import 'dart:math';

import 'package:mockito/mockito.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/control/hard_stop_command.dart';
import 'package:otus_course/game/commands/control/start_command.dart';
import 'package:otus_course/game/commands/interpret_command.dart';
import 'package:otus_course/game/commands/move_command.dart';
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

  late final SeparateGameLoop commandQueue;
  late final WebSocketEndpoint endpoint;
  late final WebSocket client;

  setUpAll(() {
    commandQueue = SeparateGameLoop();
    endpoint = WebSocketEndpoint();

    initIoC();
    IoC.pushNewScope(scopeName: 'test');
    IoC.get<Map<String, CommandQueue>>(instanceName: 'GameThreads')['simple'] =
        commandQueue;

    final gameObject = UObject();
    gameObject.setProperty('id', '548');
    gameObject.setProperty('position', Point(0, 0));
    IoC.get<List<UObject>>(instanceName: 'GameObjects').add(gameObject);
  });

  tearDown(() {
    client.close();
  });

  group('web socket endpoint test', () {
    test('if client send message then get InterpretCommand and MoveCommand',
        () async {
      client = WebSocket(Uri(
        scheme: 'ws',
        host: WebSocketEndpoint.host,
        port: WebSocketEndpoint.port,
      ));
      await endpoint.start();
      StartCommand(commandQueue).execute();
      await client.connection.firstWhere((state) => state is Connected);
      client.send(jsonEncode(incomingMessageJson));
      await expectLater(
        commandQueue.queueStreamController.stream,
        emitsInOrder([isA<InterpretCommand>(), isA<MoveCommand>()]),
      );
      commandQueue.putCommand(HardStopCommand(commandQueue));
    });
  });
}
