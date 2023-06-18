typedef Action = Future<void> Function();

abstract class GameLoopState {
  Action? action();
}