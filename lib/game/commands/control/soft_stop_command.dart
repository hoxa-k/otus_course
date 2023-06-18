import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/game_loop_soft_stop_state.dart';
import 'package:otus_course/game/separate_game_loop.dart';

class SoftStopCommand implements ICommand {
  final SeparateGameLoop queue;

  SoftStopCommand(this.queue);

  @override
  void execute() {
    queue.setState(GameLoopSoftStopState(queue, queue.state));
  }
}
