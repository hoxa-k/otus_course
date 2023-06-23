import 'dart:math';

import 'package:otus_course/game/commands/change_velocity_interface.dart';
import 'package:otus_course/game/commands/command_interface.dart';

class StopMoveCommand implements ICommand {
  final ChangeableVelocity changeableVelocity;

  StopMoveCommand(this.changeableVelocity);

  @override
  void execute() {
    changeableVelocity.setVelocity(Point(0, 0));
  }
}
