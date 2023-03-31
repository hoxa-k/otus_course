import 'package:mockito/mockito.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/helpers/log_exception_command.dart';
import 'package:test/test.dart';

class MockException implements Exception {}

class MockICommand extends Mock implements ICommand {}

void main() {
  test('log exception command test', () {
    final exception = MockException();
    final command = MockICommand();

    LogExceptionCommand(command, exception: exception).execute();

    expect(
      () => LogExceptionCommand(command, exception: exception).execute(),
      prints(allOf(
        contains(exception.runtimeType.toString()),
        contains(command.runtimeType.toString()),
      )),
    );
  });
}
