import 'dart:math';

import 'package:otus_course/game/commands/macro/burn_fuel_motion_command.dart';
import 'package:otus_course/game/exceptions/command_exception.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:test/test.dart';

void main() {
  group('burn fuel motion command test', () {
    test('calculation success test', () {
      final gameObject = UObject();
      gameObject.setProperty('position', Point(12, 5));
      gameObject.setProperty('velocity', Point(-7, 3));

      gameObject.setProperty('fuel_level', 5);
      gameObject.setProperty('fuel_consumption_velocity', 1);

      BurnFuelMotionCommand(gameObject).execute();

      expect(gameObject.getProperty('position'), Point(5, 8));
      expect(gameObject.getProperty('fuel_level'), 4);
    });

    test('calculation fail test', () {
      final gameObject = UObject();
      gameObject.setProperty('position', Point(12, 5));
      gameObject.setProperty('velocity', Point(-7, 3));

      gameObject.setProperty('fuel_level', 0);
      gameObject.setProperty('fuel_consumption_velocity', 1);

      expect(
        () => BurnFuelMotionCommand(gameObject).execute(),
        throwsA(isA<CommandException>()),
      );
      expect(gameObject.getProperty('position'), Point(12, 5));
    });
  });
}
