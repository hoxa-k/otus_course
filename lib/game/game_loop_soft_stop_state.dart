import 'package:otus_course/game/game_loop_state.dart';
import 'package:otus_course/game/separate_game_loop.dart';

class GameLoopSoftStopState implements GameLoopState{
  final SeparateGameLoop gameLoop;
  final GameLoopState prevState;
  GameLoopSoftStopState(this.gameLoop, this.prevState);

  @override
  Action? action() {
    if (!gameLoop.queueIsNotEmpty) {
      return null;
    }
    else {
      return prevState.action();
    }
  }

}