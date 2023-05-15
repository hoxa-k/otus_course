import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/separate_game_loop.dart';

class SoftStopCommand implements ICommand {
  final SeparateGameLoop queue;

  SoftStopCommand(this.queue);

  @override
  void execute() {
    Action currentAction = queue.action;
    queue.action = (gameLoop) async {
      gameLoop.repeat = gameLoop.queueIsNotEmpty;
      if (!gameLoop.repeat) return;
      await currentAction(gameLoop);
    };
  }
}
