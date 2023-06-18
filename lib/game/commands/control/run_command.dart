import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/game_loop_default_state.dart';
import 'package:otus_course/game/separate_game_loop.dart';
import 'package:otus_course/ioc.dart';

class RunCommand implements ICommand {
  final SeparateGameLoop queue;

  RunCommand(this.queue);

  @override
  void execute() {
    queue.setState(GameLoopDefaultState(queue));
  }
}
