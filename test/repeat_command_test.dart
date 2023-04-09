import 'package:mockito/mockito.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/helpers/repeat_command.dart';
import 'package:test/test.dart';

class MockException implements Exception {}

class MockICommand extends Mock implements ICommand {}

void main() {
  test('repeat command test', () {
    final exception = MockException();
    final command = MockICommand();

    RepeatCommand(command, exception: exception).execute();

    verify(command.execute()).called(1);
  });
}
