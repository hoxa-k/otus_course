import 'package:otus_course/game/commands/colliding_interface.dart';
import 'package:otus_course/game/commands/collision_detection/collision_detection_command.dart';
import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/macro/macro_command.dart';
import 'package:otus_course/game/models/game_field_model.dart';
import 'package:otus_course/ioc.dart';

class RegisterInGameFieldCommand implements ICommand {
  final GameFieldModel field;
  final Colliding object;

  RegisterInGameFieldCommand({required this.object, required this.field});

  @override
  void execute() {
    final fieldX = ((object.getPosition().x - field.offset) ~/ field.step);
    final fieldY = ((object.getPosition().y - field.offset) ~/ field.step);
    for (var rows in field.collidingObjects) {
      for (var item in rows) {
        item.removeWhere((element) =>
            element.getId() == object.getId());
      }
    }
    final existsObjects = List.from(field.collidingObjects[fieldX][fieldY]);
    field.collidingObjects[fieldX][fieldY].add(object);

    if (existsObjects.isEmpty) return;

    //ставим команду в очередь игры
    IoC.get<ICommand>(
      instanceName: 'Helpers.PutToQueue',
      param1: field.gameId,
      param2: MacroCommand(
        commandList: existsObjects
            .map((e) => CollisionDetectionCommand(e, object))
            .toList(),
      ),
    ).execute();
  }
}
