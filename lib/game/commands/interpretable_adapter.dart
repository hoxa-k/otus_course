import 'package:otus_course/game/commands/interpretable.dart';
import 'package:otus_course/game/u_object.dart';

class InterpretableAdapter implements Interpretable {
  final UObject message;

  InterpretableAdapter(this.message);

  @override
  String getGameId() => message.getProperty('game_id');

  @override
  String getObjectId() => message.getProperty('game_object_id');

  @override
  String getOperationId() => message.getProperty('command_id');

  @override
  getArgs() => message.getProperty('args');

  @override
  getOwner() => message.getProperty('owner');
}