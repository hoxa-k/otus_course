import 'dart:math';

import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/interpret_command.dart';
import 'package:otus_course/game/commands/interpretable_adapter.dart';
import 'package:otus_course/game/commands/macro/macro_command.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/init_ioc.dart';
import 'package:otus_course/game/separate_game_loop.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:otus_course/ioc.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockMoveCommand extends Mock implements ICommand {}

class MockInitCommand extends Mock implements ICommand {}

class MockStopCommand extends Mock implements ICommand {}

void main() {
  //jwt for {'user': 'user1', 'game_id': 'simple'}
  final jwt =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoidXNlcjEiLCJnYW1lX2lkIjoic2ltcGxlIiwiaWF0IjoxNjg1OTUwMzQxfQ.QMKeTMjRExl31vWgndUbhbGqXb7uhGXwUPkTVL8FDpg';

  final messageStartMove = UObject.fromJson({
    'game_id': 'simple',
    'game_object_id': '548',
    'command_id': 'start_move',
    'jwt': jwt,
    'args': [0, 2],
  });

  final messageStopMove = UObject.fromJson({
    'game_id': 'simple',
    'game_object_id': '548',
    'command_id': 'stop_move',
    'jwt': jwt,
    'args': [0, 2],
  });

  late final SeparateGameLoop commandQueue;

  setUpAll(() {
    initIoC();
    commandQueue = SeparateGameLoop();
    IoC.pushNewScope(scopeName: 'test');
    IoC.get<GameCommandsMap>(instanceName: 'GameCommands')['simple'] = {
      'start_move': ['Init', 'Move'],
      'stop_move': ['Stop'],
    };
    IoC.registerFactoryParam<ICommand, UObject, dynamic>(
      (param1, _) => MockMoveCommand(),
      instanceName: 'Command.Move',
    );
    IoC.registerFactoryParam<ICommand, UObject, dynamic>(
      (param1, _) => MockInitCommand(),
      instanceName: 'Command.Init',
    );
    IoC.registerFactoryParam<ICommand, UObject, dynamic>(
      (param1, _) => MockStopCommand(),
      instanceName: 'Command.Stop',
    );
    IoC.get<Map<String, CommandQueue>>(instanceName: 'GameThreads')['simple'] =
        commandQueue;
    IoC.registerSingleton<String>('SecretKey', instanceName: 'SecretKey');

    final gameObject = UObject();
    gameObject.setProperty('id', '548');
    gameObject.setProperty('position', Point(0, 0));

    IoC.get<List<UObject>>(instanceName: 'GameObjects').add(gameObject);
  });

  group('interpret command test', () {
    test('interpret command создает макрокоманду', () async {
      InterpretCommand(InterpretableAdapter(messageStartMove)).execute();

      await expectLater(
        commandQueue.queueStreamController.stream,
        emitsInOrder([isA<MacroCommand>()]),
      );
    });
    test('если command_id start_move, то 2 команды в макрокоманде', () async {
      InterpretCommand(InterpretableAdapter(messageStartMove)).execute();

      final macroCommand =
          await commandQueue.queueStreamController.stream.first;
      await expectLater(
        (macroCommand as MacroCommand).commandList,
        containsAllInOrder([isA<MockInitCommand>(), isA<MockMoveCommand>()]),
      );
    });
    test('если command_id stop_move, то 1 команда в макрокоманде', () async {
      InterpretCommand(InterpretableAdapter(messageStopMove)).execute();

      final macroCommand =
          await commandQueue.queueStreamController.stream.first;
      await expectLater(
        (macroCommand as MacroCommand).commandList,
        containsAllInOrder([isA<MockStopCommand>()]),
      );
    });
  });
}
