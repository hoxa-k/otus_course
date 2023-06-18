import 'package:otus_course/game/game_loop_state.dart';
import 'package:otus_course/game/separate_game_loop.dart';

class GameLoopStopState implements GameLoopState{
  final SeparateGameLoop gameLoop;
  GameLoopStopState(this.gameLoop);

  @override
  Action? action() {
    return null;
  }

}