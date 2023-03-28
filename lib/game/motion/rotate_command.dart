import 'rotatable.dart';

class RotateCommand {
  final Rotatable rotatable;

  RotateCommand(this.rotatable);

  void run() {
    if (rotatable.getDirectionsNumber() == 0) {
      throw ArgumentError('directions number cannot be 0');
    }

    rotatable.setDirection(
        (rotatable.getDirection() + rotatable.getAngularVelocity()) %
            rotatable.getDirectionsNumber());
  }
}
