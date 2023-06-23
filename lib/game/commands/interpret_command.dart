import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/interpretable.dart';
import 'package:otus_course/game/commands/macro/macro_command.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:otus_course/ioc.dart';

class InterpretCommand implements ICommand {
  final Interpretable interpretableObject;

  InterpretCommand(this.interpretableObject);

  @override
  void execute() {
    /*
    {
      'game_id': 'simple_game',
      'object_id': '548',
      'operation_id': 'StartMove',
      'args': [0,2],
    }
    */

    //получаем игровой  объект
    final obj = IoC.get<UObject>(
      instanceName: 'GameObject',
      param1: interpretableObject.getObjectId(),
    ); // "548" получено из входящего сообщения

    if (obj.isEmpty) throw Exception('Object not found');
    //очередность комманд для цепочки обязанностей игрового объекта
    // берем из IoC GameCommands
    // по operation_id
    final operation = interpretableObject.getOperationId();
    final gameId = interpretableObject.getGameId();
    final gameCommands = IoC.get<GameCommandsMap>(
      instanceName: 'GameCommands',
    )[gameId]?[operation]
        ?.map((e) => IoC.get<ICommand>(
              instanceName: 'Command.$e',
              param1: obj,
              param2: interpretableObject.getArgs(),
            ))
        .toList();

    if (gameCommands == null || gameCommands.isEmpty) return;

    //ставим команду в очередь игры
    IoC.get<ICommand>(
      instanceName: 'Helpers.PutToQueue',
      param1: interpretableObject.getGameId(),
      param2: MacroCommand(commandList: gameCommands),
    ).execute();
  }
}
