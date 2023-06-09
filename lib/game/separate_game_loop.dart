import 'package:async/async.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/exceptions/exception_handler.dart';
import 'package:otus_course/game/game_loop_default_state.dart';
import 'package:otus_course/game/game_loop_state.dart';
import 'package:otus_course/game/startable_queue_interface.dart';
import 'package:rxdart/subjects.dart';

class SeparateGameLoop implements CommandQueue, StartableQueue {
  late final StreamQueue commandsStreamQueue;
  late final exceptionHandler = ExceptionHandler(this);
  final queueStreamController = BehaviorSubject<ICommand>();
  bool repeat = true;
  late GameLoopState state;

  bool get queueIsNotEmpty => _eventsAdded - _eventsExecuted != 0;
  int _eventsExecuted = 0;
  int _eventsAdded = 0;

  SeparateGameLoop() {
    state = GameLoopDefaultState(this);
  }

  void setState(GameLoopState state) {
    this.state = state;
  }

  @override
  void start() async {
    commandsStreamQueue = StreamQueue<ICommand>(queueStreamController.stream);
    while (state.action() != null) {
      await state.action()?.call();
      _eventsExecuted++;
    }
    _dispose();
  }

  @override
  void putCommand(ICommand command) {
    _eventsAdded++;
    queueStreamController.add(command);
  }

  void _dispose() {
    queueStreamController.close();
  }
}
