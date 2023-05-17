import 'dart:math';

import 'package:vector_math/vector_math.dart';

abstract class Movable {
  Point getPosition();
  void setPosition(Point position);
  Point getVelocity();
}