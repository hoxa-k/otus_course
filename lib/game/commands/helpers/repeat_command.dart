import 'package:otus_course/game/commands/command_interface.dart';

class RepeatCommand implements ICommand {
  final ICommand command;
  final Exception exception;

  RepeatCommand(this.command, {required this.exception});

  @override
  void execute() {
    command.execute();
  }
}

class SecondRepeatCommand extends RepeatCommand {
  SecondRepeatCommand(ICommand command, {required Exception exception})
      : super(command, exception: exception);
}
