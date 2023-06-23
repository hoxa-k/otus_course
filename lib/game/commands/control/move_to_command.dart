import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/game_loop_move_to_state.dart';
import 'package:otus_course/game/separate_game_loop.dart';

class MoveToCommand implements ICommand {
  final SeparateGameLoop queue;
  final SeparateGameLoop newQueue;

  MoveToCommand(this.queue, {required this.newQueue});

  @override
  void execute() {
    queue.setState(GameLoopMoveToState(queue, newQueue));
  }
}
