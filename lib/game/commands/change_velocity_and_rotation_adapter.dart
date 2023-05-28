import 'dart:math';

import 'package:otus_course/game/commands/change_velocity_and_rotation_interface.dart';
import 'package:otus_course/game/commands/rotatable_adapter.dart';
import 'package:otus_course/game/u_object.dart';

class ChangeVelocityAndRotationAdapter extends RotatableAdapter
    implements ChangeableVelocityAndRotation {
  ChangeVelocityAndRotationAdapter(UObject object) : super(object);

  @override
  Point? getVelocity() {
    return object.getProperty('velocity');
  }

  @override
  void setVelocity(Point velocity) {
    object.setProperty('velocity', velocity);
  }

}
