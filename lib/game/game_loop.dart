import 'dart:collection';

import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/exceptions/exception_handler.dart';

class GameLoop implements CommandQueue{
  final _duration = Duration(milliseconds: 300);
  final _commandsQueue = Queue<ICommand>();
  bool _repeat = false;
  late final exceptionHandler = ExceptionHandler(this);

  void startGame() {
    _repeat = true;
    _execute();
  }

  void stopGame() => _repeat = false;

  @override
  void putCommand(ICommand command) {
    _commandsQueue.add(command);
  }

  Future<void> _execute() async {
    while (_repeat) {
      if (_commandsQueue.isNotEmpty) {
        final command = _commandsQueue.removeFirst();
        try {
          command.execute();
        } catch (e) {
          exceptionHandler.handle(e, command);
        }
      }
      await Future<void>.delayed(_duration);
    }
  }
}
