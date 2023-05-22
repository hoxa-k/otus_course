import 'package:otus_course/game/commands/change_velocity_adapter.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/helpers/put_to_queue_command.dart';
import 'package:otus_course/game/commands/init_velocity_command.dart';
import 'package:otus_course/game/commands/move_command.dart';
import 'package:otus_course/game/commands/velocity_value_adapter.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/game_loop.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:otus_course/ioc.dart';

import 'commands/movable_adapter.dart';

void initIoC() {
  IoC.registerSingleton(<String, CommandQueue>{}, instanceName: 'GameThreads');
  IoC.registerSingleton(<UObject>[], instanceName: 'GameObjects');

  IoC.registerFactoryParam<UObject, String, void>(
    (objId, _) {
      final gameObjects = IoC.get<List<UObject>>(instanceName: 'GameObjects');
      return gameObjects
          .firstWhere((element) => element.getProperty('id') == objId);
    },
    instanceName: 'GameObject',
  );

  IoC.registerFactoryParam<CommandQueue, String, void>((gameId, _) {
    final gameThreads =
        IoC.get<Map<String, CommandQueue>>(instanceName: 'GameThreads');
    final thread = gameThreads[gameId] ?? GameLoop();
    gameThreads.putIfAbsent(gameId, () => thread);
    return thread;
  });

  IoC.registerFactoryParam<ICommand, CommandQueue, ICommand>(
    (param1, param2) => PutToQueueCommand(param1, param2),
    instanceName: 'Helpers.PutToQueue',
  );

  //Register id of commands for games
  IoC.registerSingleton(
    <String, Map<String, String>>{},
    instanceName: 'GameCommands',
  );
  IoC.get<Map<String, Map<String, String>>>(
      instanceName: 'GameCommands')['simple'] = {
    'move': 'Move',
    'init': 'InitVelocity',
  };

  //Register commands
  IoC.registerFactoryParam<ICommand, UObject, dynamic?>(
    (param1, param2) => MoveCommand(MovableAdapter(param1)),
    instanceName: 'Command.Move',
  );
  IoC.registerFactoryParam<ICommand, UObject, dynamic?>(
    (param1, param2) => InitVelocityCommand(
      ChangeVelocityAdapter(param1),
      VelocityValueAdapter.argsToPoint(param2),
    ),
    instanceName: 'Command.InitVelocity',
  );
}
