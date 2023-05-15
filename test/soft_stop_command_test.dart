import 'package:mockito/mockito.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/control/soft_stop_command.dart';
import 'package:otus_course/game/commands/control/start_command.dart';
import 'package:otus_course/game/separate_game_loop.dart';
import 'package:test/test.dart';


class MockICommand extends Mock implements ICommand {}

void main() {
  group('soft stop queue command test', () {
    test('SoftStopCommand stop cycle when queue is empty', ()
    async {
      final loop = SeparateGameLoop();
      final command = MockICommand();
      final hardStopCommand = SoftStopCommand(loop);
      Future.sync(() => StartCommand(loop).execute());
      loop.queueStreamController.onCancel =
          () {
            verify(command.execute()).called(5);
            expect(loop.commandsStreamQueue.eventsDispatched, 5);
          };
      loop.putCommand(command);
      loop.putCommand(command);
      loop.putCommand(hardStopCommand);
      loop.putCommand(command);
      loop.putCommand(command);
    });
  });
}
