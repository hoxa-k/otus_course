import 'package:otus_course/game/separate_game_loop.dart';

typedef Action = Future<void> Function();

abstract class GameLoopState {
  Action? action();
}