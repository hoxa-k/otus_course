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
    final obj = IoC.get<UObject>(
      instanceName: 'GameObject',
      param1: interpretableObject.getObjectId(),
    ); // "548" получено из входящего сообщения
    IoC.get<ICommand>(
      instanceName: 'Command.InitVelocity',
      param1: obj,
      param2: interpretableObject.getArgs(),
    ); // значение 2 получено из args переданного в сообщении
    final cmd = IoC.get<ICommand>(instanceName: 'Command.Move', param1: obj);
    final gameQueue = IoC.get<CommandQueue>(
      param1: interpretableObject.getGameId(),
    );
    IoC.get<ICommand>(
      instanceName: 'Helpers.PutToQueue',
      param1: gameQueue,
      param2: cmd,
    ).execute();
  }
}
