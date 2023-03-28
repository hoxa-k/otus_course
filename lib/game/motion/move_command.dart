import 'movable.dart';

class MoveCommand {
  final Movable movable;
  MoveCommand(this.movable);

  void run() {
      movable.setPosition(movable.getPosition() + movable.getVelocity());
  }
}