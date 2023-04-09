
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/fueled_interface.dart';

class BurnFuelCommand implements ICommand{
  final Fueled fueled;

  BurnFuelCommand(this.fueled);

  @override
  void execute() {
    final level = fueled.getFuelLevel();
    final velocity = fueled.getFuelConsumptionVelocity();
    if (level == null) throw ArgumentError();
    if (velocity == null) throw ArgumentError();
    fueled.setFuelLevel(level - velocity);
  }
}
