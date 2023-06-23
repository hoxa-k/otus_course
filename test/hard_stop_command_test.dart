import 'package:mockito/mockito.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/control/hard_stop_command.dart';
import 'package:otus_course/game/commands/control/start_command.dart';
import 'package:otus_course/game/separate_game_loop.dart';
import 'package:test/test.dart';

class MockICommand extends Mock implements ICommand {}

void main() {
  group('hard stop queue command test', () {
    test('HardStopCommand stop cycle immediately', () async {
      final loop = SeparateGameLoop();
      final command = MockICommand();
      final hardStopCommand = HardStopCommand(loop);
      Future.sync(() => StartCommand(loop).execute());

      final streamMatcher = expectLater(
          loop.queueStreamController.stream.toList(),
          completion([
            isA<MockICommand>(),
            isA<MockICommand>(),
            isA<HardStopCommand>(),
            isA<MockICommand>(),
            isA<MockICommand>()
          ]));

      loop.putCommand(command);
      loop.putCommand(command);
      loop.putCommand(hardStopCommand);
      loop.putCommand(command);
      loop.putCommand(command);

      await streamMatcher;
      verify(command.execute()).called(2);
    });
  });
}
