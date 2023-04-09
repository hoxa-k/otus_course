import 'dart:collection';

import 'package:mockito/mockito.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/helpers/log_exception_command.dart';
import 'package:otus_course/game/commands/helpers/repeat_command.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/exceptions/exception_handler.dart';
import 'package:test/test.dart';

class MockException implements Exception {}

class MockICommand extends Mock implements ICommand {}

class FakeLoop extends Fake implements CommandQueue {
  final commandQueue = Queue<ICommand>();

  @override
  void putCommand(ICommand command) {
    commandQueue.add(command);
  }
}

void main() {
  group('exception handler test', () {
    final mockCommandQueue = FakeLoop();
    final exception = MockException();
    final command = MockICommand();

    test('handle command with exception', () {
      ExceptionHandler(mockCommandQueue).handle(exception, command);

      expect(
          mockCommandQueue.commandQueue.last,
          predicate<RepeatCommand>(
            (p0) => p0.command == command && p0.exception == exception,
          ));
    });

    test('handle repeat command with exception', () {
      ExceptionHandler(mockCommandQueue)
          .handle(exception, RepeatCommand(command, exception: exception));

      expect(
          mockCommandQueue.commandQueue.last,
          predicate<LogExceptionCommand>(
            (p0) => p0.command == command && p0.exception == exception,
          ));
    });
  });
}
