import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:otus_course/game/exceptions/command_exception.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/macro/macro_command.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<ICommand>()])
import 'macro_command_test.mocks.dart';

void main() {

  test('macro command test', () {
    final command = MockICommand();
    final macroCommand = MacroCommand(
      commandList: [command, command, command],
    );

    macroCommand.execute();

    verify(command.execute()).called(3);
  });

  test('macro command test if exception return from command', () {
    final command = MockICommand();
    final errorCommand = MockICommand();
    when(errorCommand.execute()).thenThrow(CommandException());

    final macroCommand = MacroCommand(
      commandList: [command, command, errorCommand, command],
    );

    expect(() => macroCommand.execute(), throwsA(isA<CommandException>()));

    verify(command.execute()).called(2);
  });
}
