import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commands/interpretable.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
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
      'operation_id': 'move',
      'args': [0,2],
    }
    */

    //получаем игровой  объект
    final obj = IoC.get<UObject>(
      instanceName: 'GameObject',
      param1: interpretableObject.getObjectId(),
    ); // "548" получено из входящего сообщения

    //получаем команду инициализации игрового объекта
    final initCommandName = IoC.get<Map<String, Map<String, String>>>(
      instanceName: 'GameCommands',
    )[interpretableObject.getGameId()]?['init'];
    IoC.get<ICommand>(
      instanceName: 'Command.$initCommandName',
      param1: obj,
      param2: interpretableObject.getArgs(),
    ).execute();

    //получаем команду движения
    final commandName = IoC.get<Map<String, Map<String, String>>>(
      instanceName: 'GameCommands',
    )[interpretableObject.getGameId()]?[interpretableObject.getOperationId()];
    final cmd = IoC.get<ICommand>(
      instanceName: 'Command.$commandName',
      param1: obj,
      param2: interpretableObject.getArgs(),
    );

    //получаем очередь игры
    final gameQueue = IoC.get<CommandQueue>(
      param1: interpretableObject.getGameId(),
    );

    //ставим команду в очередь игры
    IoC.get<ICommand>(
      instanceName: 'Helpers.PutToQueue',
      param1: gameQueue,
      param2: cmd,
    ).execute();
  }
}
