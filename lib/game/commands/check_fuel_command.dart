import 'package:otus_course/game/exceptions/command_exception.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/fueled_interface.dart';

class CheckFuelCommand implements ICommand{
  final Fueled fueled;

  CheckFuelCommand(this.fueled);

  @override
  void execute() {
    final level = fueled.getFuelLevel();
    if (level == null) throw ArgumentError();
    if (level <= 0) throw CommandException();
  }
}
