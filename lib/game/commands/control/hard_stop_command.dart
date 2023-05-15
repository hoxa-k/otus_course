import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/separate_game_loop.dart';

class HardStopCommand implements ICommand {
  final SeparateGameLoop queue;

  HardStopCommand(this.queue);

  @override
  void execute() {
    queue.repeat = false;
  }
}
