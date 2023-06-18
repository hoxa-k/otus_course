import 'package:mockito/mockito.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/control/soft_stop_command.dart';
import 'package:otus_course/game/commands/control/start_command.dart';
import 'package:otus_course/game/separate_game_loop.dart';
import 'package:test/test.dart';

class MockICommand extends Mock implements ICommand {}

void main() {
  group('soft stop queue command test', () {
    test('SoftStopCommand stop cycle when queue is empty', () async {
      final loop = SeparateGameLoop();
      final command = MockICommand();
      Future.sync(() => StartCommand(loop).execute());
      final softStopCommand = SoftStopCommand(loop);

      final streamMatcher = expectLater(
          loop.queueStreamController.stream.toList(),
          completion([
            isA<MockICommand>(),
            isA<MockICommand>(),
            isA<SoftStopCommand>(),
            isA<MockICommand>(),
            isA<MockICommand>()
          ]));

      loop.putCommand(command);
      loop.putCommand(command);
      loop.putCommand(softStopCommand);
      loop.putCommand(command);
      loop.putCommand(command);

      await streamMatcher;
      verify(command.execute()).called(4);
    });
  });
}
