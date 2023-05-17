import 'dart:math';

import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/movable_interface.dart';

class MoveCommand implements ICommand {
  final Movable movable;

  MoveCommand(this.movable);

  @override
  void execute() {
    movable.setPosition(
      Point(
        movable.getPosition().x + movable.getVelocity().x,
        movable.getPosition().y + movable.getVelocity().y,
      ),
    );
  }
}
