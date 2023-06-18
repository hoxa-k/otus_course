import 'dart:math';

import 'package:otus_course/game/commands/colliding_interface.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/exceptions/command_exception.dart';

class CollisionDetectionCommand implements ICommand {
  final Colliding obj1;
  final Colliding obj2;

  CollisionDetectionCommand(this.obj1, this.obj2);

  @override
  void execute() {
    final x1 = obj1.getPosition().x;
    final x2 = obj2.getPosition().x;
    final y1 = obj1.getPosition().y;
    final y2 = obj2.getPosition().y;
    final r1 = obj1.getMaxSize();
    final r2 = obj1.getMaxSize();

    if (sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)) <= (r1 + r2)) {
      throw CommandException('CollisionDetected');
    }
  }
}
