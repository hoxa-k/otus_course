import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/movable_interface.dart';

class MoveCommand implements ICommand{
  final Movable movable;
  MoveCommand(this.movable);

  @override
  void execute() {
      movable.setPosition(movable.getPosition() + movable.getVelocity());
  }
}