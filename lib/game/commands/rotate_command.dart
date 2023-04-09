import 'package:otus_course/game/commands/command_interface.dart';

import 'rotatable_interface.dart';

class RotateCommand implements ICommand{
  final Rotatable rotatable;

  RotateCommand(this.rotatable);

  @override
  void execute() {
    if (rotatable.getDirectionsNumber() == 0) {
      throw ArgumentError('directions number cannot be 0');
    }

    rotatable.setDirection(
        (rotatable.getDirection() + rotatable.getAngularVelocity()) %
            rotatable.getDirectionsNumber());
  }
}
