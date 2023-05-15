import 'dart:async';

import 'package:async/async.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/exceptions/exception_handler.dart';
import 'package:otus_course/game/startable_queue_interface.dart';

typedef Action = Future<void> Function(SeparateGameLoop gameLoop);

class SeparateGameLoop implements CommandQueue, StartableQueue {
  late final StreamQueue commandsStreamQueue;
  late final exceptionHandler = ExceptionHandler(this);
  final queueStreamController = StreamController<ICommand>();
  bool repeat = true;
  Action action = (gameLoop) async {
    final command = await gameLoop.commandsStreamQueue.next;
    try {
      command.execute();
    } catch (e) {
      gameLoop.exceptionHandler.handle(e, command);
    }
  };

  bool get queueIsNotEmpty => _eventsAdded - _eventsExecuted != 0;
  int _eventsExecuted = 0;
  int _eventsAdded = 0;

  SeparateGameLoop();

  @override
  void start() async {
    commandsStreamQueue = StreamQueue<ICommand>(queueStreamController.stream);
    while (repeat) {
      await action(this);
      _eventsExecuted++;
    }
  }

  @override
  void putCommand(ICommand command) {
    _eventsAdded++;
    queueStreamController.add(command);
  }
}
