import 'dart:math';

import 'package:otus_course/game/commands/change_velocity_interface.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:vector_math/vector_math.dart';

class ChangeVelocityCommand implements ICommand {
  final ChangeableVelocity changeableVelocity;

  ChangeVelocityCommand(this.changeableVelocity) {
    if (changeableVelocity.getDirectionsNumber() == 0) throw ArgumentError();
  }

  @override
  void execute() {
    final o = changeableVelocity;
    final velocity = o.getVelocity();
    if (velocity == null) return;
    final angle =
        radians(o.getAngularVelocity() * (360 / o.getDirectionsNumber()));

    o.setVelocity(
      Point(
        (velocity.x * cos(angle) - velocity.y * sin(angle)).round(),
        (velocity.x * sin(angle) + velocity.y * cos(angle)).round(),
      ),
    );
  }
}
