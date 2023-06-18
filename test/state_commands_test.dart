import 'package:mockito/mockito.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/control/hard_stop_command.dart';
import 'package:otus_course/game/commands/control/move_to_command.dart';
import 'package:otus_course/game/commands/control/run_command.dart';
import 'package:otus_course/game/commands/control/start_command.dart';
import 'package:otus_course/game/game_loop_default_state.dart';
import 'package:otus_course/game/game_loop_move_to_state.dart';
import 'package:otus_course/game/separate_game_loop.dart';
import 'package:test/test.dart';

class MockICommand extends Mock implements ICommand {}

void main() {
  late SeparateGameLoop loop;
  late SeparateGameLoop anotherLoop;
  final command = MockICommand();
  late MoveToCommand moveToCommand;

  setUp(() {
    loop = SeparateGameLoop();
    anotherLoop = SeparateGameLoop();
    moveToCommand = MoveToCommand(loop, newQueue: anotherLoop);
  });

  tearDown(() {
    loop.putCommand(HardStopCommand(loop));
    anotherLoop.putCommand(HardStopCommand(anotherLoop));
  });

  group('State ', () {
    group('MoveToCommand test ', () {
      test('MoveToCommand move commands to another queue', () async {
        Future.sync(() => StartCommand(loop).execute());
        Future.sync(() => StartCommand(anotherLoop).execute());

        final loopMatcher = expectLater(
          loop.queueStreamController.stream,
          emitsInOrder(
              [isA<MoveToCommand>(), isA<MockICommand>(), isA<MockICommand>()]),
        );
        final anotherLoopMatcher = expectLater(
          anotherLoop.queueStreamController.stream,
          emitsInOrder([isA<MockICommand>(), isA<MockICommand>()]),
        );

        loop.putCommand(moveToCommand);
        loop.putCommand(command);
        loop.putCommand(command);

        await loopMatcher;

        await anotherLoopMatcher;

        expect(loop.state, isA<GameLoopMoveToState>());
      });
    });
    group('RunCommand test ', () {
      test('RunCommand reset to default state', () async {
        final runCommand = RunCommand(loop);

        Future.sync(() => StartCommand(loop).execute());
        Future.sync(() => StartCommand(anotherLoop).execute());

        final loopMatcher = expectLater(
          loop.queueStreamController.stream,
          emitsInOrder([
            isA<MoveToCommand>(),
            isA<MockICommand>(),
            isA<RunCommand>(),
            isA<MockICommand>(),
          ]),
        );
        final anotherLoopMatcher = expectLater(
          anotherLoop.queueStreamController.stream,
          emitsInOrder([isA<MockICommand>()]),
        );

        loop.putCommand(moveToCommand);
        loop.putCommand(command);
        loop.putCommand(runCommand);
        loop.putCommand(command);

        await loopMatcher;

        await anotherLoopMatcher;

        expect(loop.state, isA<GameLoopDefaultState>());
      });
    });
  });
}
