import 'package:otus_course/game/game_loop_state.dart';
import 'package:otus_course/game/separate_game_loop.dart';

class GameLoopMoveToState implements GameLoopState{
  final SeparateGameLoop gameLoop;
  final SeparateGameLoop newGameLoop;
  GameLoopMoveToState(this.gameLoop, this.newGameLoop);

  @override
  Action? action() {
    return () async {
      final command = await gameLoop.commandsStreamQueue.next;
      newGameLoop.putCommand(command);
    };
  }

}