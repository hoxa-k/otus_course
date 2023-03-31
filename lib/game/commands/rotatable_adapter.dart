import 'package:otus_course/game/commands/rotatable_interface.dart';
import 'package:otus_course/game/u_object.dart';

class RotatableAdapter implements Rotatable {
  final UObject object;

  RotatableAdapter(this.object) {
    if (object.getProperty('angular_velocity') == null ||
        object.getProperty('direction') == null ||
        object.getProperty('directions_number') == null) {
      throw ArgumentError();
    }
  }

  @override
  int getAngularVelocity() {
    return object.getProperty('angular_velocity');
  }

  @override
  int getDirection() {
    return object.getProperty('direction');
  }

  @override
  int getDirectionsNumber() {
    return object.getProperty('directions_number');
  }

  @override
  void setDirection(int newDirection) {
    object.setProperty('direction', newDirection);
  }
}
