import 'dart:math';

import 'package:otus_course/game/motion/rotatable_adapter.dart';
import 'package:otus_course/game/motion/rotate_command.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<UObject>()])
import 'rotate_command_test.mocks.dart';

void main() {
  test('rotate command test', () {
    final gameObject = UObject();
    gameObject.setProperty('directions_number', 8);
    gameObject.setProperty('direction', 0);
    gameObject.setProperty('angular_velocity', 4);

    RotateCommand(RotatableAdapter(gameObject)).run();

    expect(gameObject.getProperty('direction'), 4);
  });

  test('if directions_number == 0 then throw exception', () {
    final gameObject = MockUObject();
    when(gameObject.getProperty(any)).thenReturn(10);
    when(gameObject.getProperty('directions_number')).thenReturn(0);
    expect(() => RotateCommand(RotatableAdapter(gameObject)).run(), throwsArgumentError);
  });

  test('if can not read directions_number then throw exception', () {
    final gameObject = MockUObject();
    when(gameObject.getProperty(any)).thenReturn(0);
    when(gameObject.getProperty('directions_number')).thenThrow(ArgumentError());
    expect(() => RotateCommand(RotatableAdapter(gameObject)).run(), throwsArgumentError);
  });

  test('if can not read velocity then throw exception', () {
    final gameObject = MockUObject();
    when(gameObject.getProperty(any)).thenReturn(10);
    when(gameObject.getProperty('angular_velocity')).thenThrow(ArgumentError());
    expect(() => RotateCommand(RotatableAdapter(gameObject)).run(), throwsArgumentError);
  });

  test('if can not read velocity then throw exception', () {
    final gameObject = MockUObject();
    when(gameObject.getProperty(any)).thenReturn(10);
    when(gameObject.setProperty('direction', any)).thenThrow(ArgumentError());
    expect(() => RotateCommand(RotatableAdapter(gameObject)).run(), throwsArgumentError);
  });
}
