import 'package:otus_course/game/game_loop_state.dart';
import 'package:otus_course/game/separate_game_loop.dart';

class GameLoopDefaultState implements GameLoopState{
  final SeparateGameLoop gameLoop;
  GameLoopDefaultState(this.gameLoop);

  @override
  Action? action() {
    return () async {
      final command = await gameLoop.commandsStreamQueue.next;
      try {
        command.execute();
      } catch (e) {
        gameLoop.exceptionHandler.handle(e, command);
      }
    };
  }

}