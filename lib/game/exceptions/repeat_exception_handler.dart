import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/helpers/log_exception_command.dart';
import 'package:otus_course/game/commands/helpers/repeat_command.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';

class RepeatExceptionHandler {
  final CommandQueue commandQueue;

  RepeatExceptionHandler(this.commandQueue);

  void handle(dynamic e, ICommand command) {
    if (command is SecondRepeatCommand) {
      commandQueue.putCommand(LogExceptionCommand(
        command.command,
        exception: e,
      ));
      return;
    }
    if (command is RepeatCommand) {
      commandQueue.putCommand(SecondRepeatCommand(
        command.command,
        exception: e,
      ));
      return;
    }
    commandQueue.putCommand(RepeatCommand(command, exception: e));
  }
}
