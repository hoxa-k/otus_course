import 'dart:math';

import 'package:otus_course/game/u_object.dart';

import 'colliding_interface.dart';

class CollidingAdapter implements Colliding {
  final UObject object;

  CollidingAdapter(this.object);

  @override
  String getId() {
    return object.getProperty('object_id');
  }

  @override
  Point<num> getPosition() {
    return object.getProperty('position') as Point<num>;
  }

  @override
  int getMaxSize() {
    return object.getProperty('max_size');
  }
}
