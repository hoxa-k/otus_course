import 'dart:math';

import 'package:otus_course/game/commands/change_velocity_interface.dart';
import 'package:otus_course/game/commands/rotatable_adapter.dart';
import 'package:otus_course/game/u_object.dart';

class ChangeVelocityAdapter extends RotatableAdapter
    implements ChangeableVelocity {
  ChangeVelocityAdapter(UObject object) : super(object);

  @override
  Point<num>? getVelocity() {
    return object.getProperty('velocity');
  }

  @override
  void setVelocity(Point<num> velocity) {
    object.setProperty('velocity', velocity);
  }

}
