import 'package:otus_course/game/commands/command_interface.dart';

class MacroCommand implements ICommand {
  final List<ICommand> commandList;

  MacroCommand({required this.commandList});

  @override
  void execute() {
    for (final command in commandList) {
      try {
        command.execute();
      } catch (ex) {
        rethrow;
      }
    }
  }
}
