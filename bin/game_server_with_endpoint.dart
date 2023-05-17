import 'dart:math';

import 'package:otus_course/game/commands/control/start_command.dart';
import 'package:otus_course/game/commands/interpret_command.dart';
import 'package:otus_course/game/commands/interpretable_adapter.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/init_ioc.dart';
import 'package:otus_course/game/models/incoming_message.dart';
import 'package:otus_course/game/separate_game_loop.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:otus_course/ioc.dart';

void main(List<String> arguments) async {
  initIoC();

  final simpleGamesCommandQueue = SeparateGameLoop();
  StartCommand(simpleGamesCommandQueue).execute();

  IoC.get<Map<String, CommandQueue>>(instanceName: 'GameThreads')['simple'] =
      simpleGamesCommandQueue;

  final gameObject = UObject();
  gameObject.setProperty('id', '548');
  gameObject.setProperty('position', Point(0, 0));
  IoC.get<List<UObject>>(instanceName: 'GameObjects').add(gameObject);

  final incomingMessageJson = {
    'game_id': 'simple',
    'game_object_id': '548',
    'command_id': 'move',
    'args': [0, 2],
  };

  final interpretCommand = InterpretCommand(
    InterpretableAdapter(IncomingMessage.fromJson(incomingMessageJson)),
  );

  interpretCommand.execute();
}
