import 'package:otus_course/game/commands/command_interface.dart';

class PrintDebugCommand implements ICommand {
  final String debugString;

  PrintDebugCommand(this.debugString);

  @override
  void execute() {
    print(debugString);
  }
}
