import 'package:mockito/mockito.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/control/start_command.dart';
import 'package:otus_course/game/game_loop_stop_state.dart';
import 'package:otus_course/game/separate_game_loop.dart';
import 'package:test/test.dart';

class MockICommand extends Mock implements ICommand {}

void main() {

  group('start game queue command test', () {
    test('StartCommand init separate loop and start cycle', () async {
      final loop = SeparateGameLoop();
      final command = MockICommand();
      Future.sync(() => StartCommand(loop).execute());
      expectLater(loop.commandsStreamQueue, emits(command));
      loop.queueStreamController.onCancel =
          () => verify(command.execute()).called(1);
      loop.putCommand(command);
      loop.setState(GameLoopStopState(loop));
      loop.putCommand(command);
    });
  });
}
