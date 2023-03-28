import 'package:otus_course/game/u_object.dart';

import 'rotatable.dart';

class RotatableAdapter implements Rotatable {
  final UObject object;

  RotatableAdapter(this.object);

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
