import 'dart:math';

import 'package:otus_course/game/commands/rotatable_interface.dart';

abstract class ChangeableVelocity implements Rotatable{
    Point? getVelocity();
    void setVelocity(Point velocity);
}