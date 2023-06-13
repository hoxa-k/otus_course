import 'package:otus_course/game/commands/colliding_interface.dart';

class GameFieldModel {
  final String gameId;
  final int step;
  final int offset;
  final int numX;
  final int numY;
  late final List<List<List<Colliding>>> collidingObjects;

  GameFieldModel({
    required this.gameId,
    required this.step,
    this.offset = 0,
    this.numX = 100,
    this.numY = 50,
  }) {
    collidingObjects = List.generate(
      numX,
      (index) => List.generate(numY, (index) => <Colliding>[]),
    );
  }
}
