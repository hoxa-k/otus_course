import 'dart:math';

import 'package:otus_course/game/commands/movable_adapter.dart';
import 'package:otus_course/game/commands/move_command.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<UObject>()])
import 'move_command_test.mocks.dart';

void main() {
  test('move command test', () {
    final gameObject = UObject();
    gameObject.setProperty('position', Point(12, 5));
    gameObject.setProperty('velocity', Point(-7, 3));

    MoveCommand(MovableAdapter(gameObject)).execute();

    expect(gameObject.getProperty('position'), Point(5, 8));
  });

  test('if can not read position then throw exception', () {
    final gameObject = MockUObject();
    when(gameObject.getProperty(any)).thenReturn(Point(12, 5));
    when(gameObject.getProperty('position')).thenThrow(ArgumentError());
    expect(() => MoveCommand(MovableAdapter(gameObject)).execute(), throwsArgumentError);
  });

  test('if can not read velocity then throw exception', () {
    final gameObject = MockUObject();
    when(gameObject.getProperty(any)).thenReturn(Point(12, 5));
    when(gameObject.getProperty('velocity')).thenThrow(ArgumentError());
    expect(() => MoveCommand(MovableAdapter(gameObject)).execute(), throwsArgumentError);
  });

  test('if can not set position then throw exception', () {
    final gameObject = MockUObject();
    when(gameObject.getProperty(any)).thenReturn(Point(12, 5));
    when(gameObject.setProperty('position', any)).thenThrow(ArgumentError());
    expect(() => MoveCommand(MovableAdapter(gameObject)).execute(), throwsArgumentError);
  });
}
