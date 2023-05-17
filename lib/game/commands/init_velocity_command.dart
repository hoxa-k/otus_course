import 'dart:math';

import 'package:otus_course/game/commands/change_velocity_interface.dart';
import 'package:otus_course/game/commands/command_interface.dart';

class InitVelocityCommand implements ICommand {
  final ChangeableVelocity changeableVelocity;
  final Point velocity;

  InitVelocityCommand(this.changeableVelocity, this.velocity);

  @override
  void execute() {
    changeableVelocity.setVelocity(velocity);
  }
}
