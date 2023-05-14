import 'package:otus_course/game/commands/interpretable.dart';
import 'package:otus_course/game/models/incoming_message.dart';

class InterpretableAdapter implements Interpretable {
  final IncomingMessage message;
  InterpretableAdapter(this.message);

  @override
  getArgs() => message.args;
  @override
  int getObjectId() => message.gameObjectId;

  @override
  String getOperationId() => message.commandId;

  @override
  int getGameId() => message.gameId;



}