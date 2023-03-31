import 'dart:math';

import 'package:otus_course/game/commands/macro/rotate_and_change_velocity_command.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:test/test.dart';

void main() {
  group('rotate and change velocity test', () {
    test('calculation success test', () {
      final gameObject = UObject();
      gameObject.setProperty('directions_number', 8);
      gameObject.setProperty('direction', 0);
      gameObject.setProperty('angular_velocity', 2);
      gameObject.setProperty('velocity', Point(-1, 0));

      RotateAndChangeVelocityCommand(gameObject).execute();

      expect(gameObject.getProperty('velocity'), Point(0, -1));
      expect(gameObject.getProperty('direction'), 2);
    });

    test('if no velocity then not change it', () {
      final gameObject = UObject();
      gameObject.setProperty('directions_number', 8);
      gameObject.setProperty('direction', 0);
      gameObject.setProperty('angular_velocity', 2);

      RotateAndChangeVelocityCommand(gameObject).execute();

      expect(gameObject.getProperty('velocity'), isNull);
      expect(gameObject.getProperty('direction'), 2);
    });

    test('if no parameter throw ArgumentError', () {
      final gameObject = UObject();
      gameObject.setProperty('angular_velocity', 2);

      expect(() => RotateAndChangeVelocityCommand(gameObject).execute(), throwsArgumentError);
    });

  });
}
