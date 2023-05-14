import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/helpers/put_to_queue_command.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/game_loop.dart';
import 'package:otus_course/ioc.dart';

void initIoC() {
  IoC.registerSingleton(Map<int, CommandQueue>, instanceName: 'GameThreads');
  IoC.registerFactoryParam<CommandQueue, int, void>((gameId, _) {
    final gameThreads =
    IoC.get<Map<int, CommandQueue>>(instanceName: 'GameThreads');
    final thread = gameThreads[gameId] ?? GameLoop();
    gameThreads.putIfAbsent(gameId, () => thread);
    return thread;
  });
  IoC.registerFactoryParam<ICommand, CommandQueue, ICommand>(
        (param1, param2) => PutToQueueCommand(param1, param2),
    instanceName: 'Helpers.PutToQueue',
  );
}