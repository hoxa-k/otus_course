import 'dart:math';

import 'package:otus_course/game/commands/change_velocity_interface.dart';
import 'package:otus_course/game/u_object.dart';

class ChangeVelocityAdapter implements ChangeableVelocity {
  final UObject object;

  ChangeVelocityAdapter(this.object);

  @override
  Point? getVelocity() {
    return object.getProperty('velocity');
  }

  @override
  void setVelocity(Point velocity) {
    object.setProperty('velocity', velocity);
  }
}
