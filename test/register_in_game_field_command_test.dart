import 'dart:math';

import 'package:mocktail/mocktail.dart';
import 'package:otus_course/game/commands/colliding_adapter.dart';
import 'package:otus_course/game/commands/colliding_interface.dart';
import 'package:otus_course/game/commands/collision_detection/collision_detection_command.dart';
import 'package:otus_course/game/commands/collision_detection/register_in_game_field_command.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/macro/macro_command.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/exceptions/command_exception.dart';
import 'package:otus_course/game/game_loop.dart';
import 'package:otus_course/game/init_ioc.dart';
import 'package:otus_course/game/models/game_field_model.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:otus_course/ioc.dart';
import 'package:test/test.dart';

class MockICommand extends Fake implements ICommand {}

class MockGameLoop extends Mock implements GameLoop {}

void main() {
  UObject gameObject = UObject();
  Colliding object = CollidingAdapter(gameObject);
  GameFieldModel gameField = GameFieldModel(gameId: 'test', step: 5);

  setUpAll(() {
    registerFallbackValue(MockICommand());
  });

  setUp(() {
    gameObject.setProperty('object_id', '123');
    gameObject.setProperty('position', Point(16, 23));
    gameObject.setProperty('max_size', 1);
    gameField = GameFieldModel(gameId: 'test', step: 5);
  });

  group('RegisterInGameFieldCommand', () {
    test('test write to list of area colliding objects', () async {
      RegisterInGameFieldCommand(
        object: object,
        field: gameField,
      ).execute();

      expect(gameField.collidingObjects[3][4], contains(object));
    });
    test('test remove from previous list of area colliding objects', () async {
      gameField.collidingObjects[3][4].add(object);

      gameObject.setProperty('position', Point(23, 23));

      RegisterInGameFieldCommand(
        object: object,
        field: gameField,
      ).execute();

      expect(gameField.collidingObjects[3][4], isNot(contains(object)));
      expect(gameField.collidingObjects[4][4], contains(object));
    });
    group('test macro command for collision detection', () {
      late MockGameLoop loop;
      setUp((){
        IoC.pushNewScope(scopeName: 'test');
        initIoC();
        loop = MockGameLoop();
        IoC.get<Map<String, CommandQueue>>(instanceName: 'GameThreads')
            .putIfAbsent('test', () => loop);
      });
      tearDown((){
        IoC.popScope();
        IoC.reset;
      });
      test('test 1 object in area', () async {
        final gameObjectAnother = UObject();
        gameObjectAnother.setProperty('object_id', '125');
        gameObjectAnother.setProperty('position', Point(18, 24));
        gameField.collidingObjects[3][4]
            .add(CollidingAdapter(gameObjectAnother));

        RegisterInGameFieldCommand(
          object: object,
          field: gameField,
        ).execute();

        final captured = verify(() => loop.putCommand(captureAny())).captured;
        final command = captured.first;
        expect(command, isA<MacroCommand>());
        expect(command.commandList, contains(isA<CollisionDetectionCommand>()));
        expect(command.commandList.length, equals(1));
      });
      test('test 3 objects in area', () async {
        final gameObjectAnother = UObject();
        gameObjectAnother.setProperty('object_id', '125');
        gameObjectAnother.setProperty('position', Point(18, 24));
        final gameObjectAnother2 = UObject();
        gameObjectAnother2.setProperty('object_id', '126');
        gameObjectAnother2.setProperty('position', Point(18, 24));
        final gameObjectAnother3 = UObject();
        gameObjectAnother3.setProperty('object_id', '127');
        gameObjectAnother3.setProperty('position', Point(18, 24));
        gameField.collidingObjects[3][4]
            .add(CollidingAdapter(gameObjectAnother));
        gameField.collidingObjects[3][4]
            .add(CollidingAdapter(gameObjectAnother2));
        gameField.collidingObjects[3][4]
            .add(CollidingAdapter(gameObjectAnother3));

        RegisterInGameFieldCommand(
          object: object,
          field: gameField,
        ).execute();

        final captured = verify(() => loop.putCommand(captureAny())).captured;
        final command = captured.first;
        expect(command, isA<MacroCommand>());
        expect(command.commandList, contains(isA<CollisionDetectionCommand>()));
        expect(command.commandList.length, equals(3));
      });
      test('test no objects in area', () async {
        RegisterInGameFieldCommand(
          object: object,
          field: gameField,
        ).execute();

        verifyNever(() => loop.putCommand(captureAny()));
      });
    });
    group('test macro command for collision detection with several areas', () {
      late MockGameLoop loop;
      setUp((){
        IoC.pushNewScope(scopeName: 'test');
        initIoC();
        loop = MockGameLoop();
        IoC.get<Map<String, CommandQueue>>(instanceName: 'GameThreads')
            .putIfAbsent('test', () => loop);
      });
      tearDown((){
        IoC.popScope();
        IoC.reset;
      });

      test('test collision detection in one area', () async {
        final gameObjectAnother = UObject();
        gameObjectAnother.setProperty('object_id', '125');
        gameObjectAnother.setProperty('position', Point(18, 24));
        gameObjectAnother.setProperty('max_size', 3);
        gameField.collidingObjects[3][4]
            .add(CollidingAdapter(gameObjectAnother));

        RegisterInGameFieldCommand(
          object: object,
          field: gameField,
        ).execute();

        final captured = verify(() => loop.putCommand(captureAny())).captured;
        final command = captured.first;
        expect(() => command.execute(), throwsA(predicate((e) => e is CommandException && e.message == 'CollisionDetected')));
      });
      test('test no collision detection. second object in another area', () async {
        final gameObjectAnother = UObject();
        gameObjectAnother.setProperty('object_id', '125');
        gameObjectAnother.setProperty('position', Point(18, 25));
        gameObjectAnother.setProperty('max_size', 3);
        gameField.collidingObjects[3][5]
            .add(CollidingAdapter(gameObjectAnother));

        RegisterInGameFieldCommand(
          object: object,
          field: gameField,
        ).execute();

        verifyNever(() => loop.putCommand(captureAny()));
      });
      test('test collision detection. second object in another area', () async {
        final gameObjectAnother = UObject();
        gameObjectAnother.setProperty('object_id', '125');
        gameObjectAnother.setProperty('position', Point(18, 25));
        gameObjectAnother.setProperty('max_size', 3);

        gameField.collidingObjects[3][5]
            .add(CollidingAdapter(gameObjectAnother));

        final anotherGameField = GameFieldModel(gameId: 'test', step: 5, offset: 1,);
        anotherGameField.collidingObjects[3][4]
            .add(CollidingAdapter(gameObjectAnother));

        RegisterInGameFieldCommand(
          object: object,
          field: gameField,
        ).execute();

        verifyNever(() => loop.putCommand(captureAny()));

        RegisterInGameFieldCommand(
          object: object,
          field: anotherGameField,
        ).execute();

        final captured = verify(() => loop.putCommand(captureAny())).captured;
        final command = captured.first;
        expect(() => command.execute(), throwsA(predicate((e) => e is CommandException && e.message == 'CollisionDetected')));
      });
    });
  });
}
