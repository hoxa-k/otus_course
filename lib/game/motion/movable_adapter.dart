import 'dart:math';

import 'package:otus_course/game/u_object.dart';

import 'movable.dart';

class MovableAdapter implements Movable {
  final UObject object;

  MovableAdapter(this.object);

  @override
  Point<num> getPosition() {
    return object.getProperty('position') as Point<num>;
  }

  @override
  Point<num> getVelocity() {
    return object.getProperty('velocity') as Point<num>;
  }

  @override
  void setPosition(Point<num> position) {
    object.setProperty('position', position);
  }
}
