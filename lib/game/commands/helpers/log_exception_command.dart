import 'package:otus_course/game/commands/command_interface.dart';

class LogExceptionCommand implements ICommand {
  final ICommand command;
  final Exception exception;
  LogExceptionCommand(this.command, {required this.exception});

  @override
  void execute() {
    print('${command.runtimeType} throw ${exception.runtimeType}');
  }

}