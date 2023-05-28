import 'package:otus_course/game/commands/interpretable.dart';
import 'package:otus_course/game/models/incoming_message.dart';

class InterpretableAdapter implements Interpretable {
  final IncomingMessage message;

  InterpretableAdapter(this.message);

  @override
  String getGameId() => message.gameId;

  @override
  String getObjectId() => message.gameObjectId;

  @override
  String getOperationId() => message.commandId;

  @override
  getArgs() => message.args;
}