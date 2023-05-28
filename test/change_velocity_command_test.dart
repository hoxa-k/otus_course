import 'dart:math';

import 'package:otus_course/game/commands/change_velocity_and_rotation_adapter.dart';
import 'package:otus_course/game/commands/change_velocity_command.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:test/test.dart';

void main() {
  group('change velocity test', () {
    test('calculation success test', () {
      final gameObject = UObject();
      gameObject.setProperty('directions_number', 8);
      gameObject.setProperty('direction', 0);
      gameObject.setProperty('angular_velocity', 2);
      gameObject.setProperty('velocity', Point(-1, 0));

      ChangeVelocityCommand(ChangeVelocityAndRotationAdapter(gameObject)).execute();

      expect(gameObject.getProperty('velocity'), Point(0, -1));
    });

    test('if no velocity then not change it', () {
      final gameObject = UObject();
      gameObject.setProperty('directions_number', 8);
      gameObject.setProperty('direction', 0);
      gameObject.setProperty('angular_velocity', 2);

      ChangeVelocityCommand(ChangeVelocityAndRotationAdapter(gameObject)).execute();

      expect(gameObject.getProperty('velocity'), isNull);
    });
  });
}
