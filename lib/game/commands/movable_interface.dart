import 'dart:math';

abstract class Movable {
  Point getPosition();
  void setPosition(Point position);
  Point getVelocity();
}