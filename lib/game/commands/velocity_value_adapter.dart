import 'dart:math';

class VelocityValueAdapter {
  static Point argsToPoint(dynamic value) {
    assert(value is List);
    return Point(value[0], value[1]);
  }
}
