import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:otus_course/common_tools/network/web_socket_endpoint.dart';
import 'package:otus_course/game/commands/interpret_command.dart';
import 'package:otus_course/game/commands/interpretable_adapter.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/models/incoming_message.dart';
import 'package:otus_course/ioc.dart';

class GameWebSocketEndpoint extends WebSocketEndpoint {
  @override
  void processMessage(String connectionName, dynamic json) {
    final message = IncomingMessage.fromJson(json);
    if (!_checkJwt(message)) {
      send(connectionName, 'auth error');
      return;
    }
    final gameId = message.gameId;
    final gameQueue = IoC.get<CommandQueue>(param1: gameId);
    gameQueue.putCommand(InterpretCommand(InterpretableAdapter(message)));
  }

  bool _checkJwt(IncomingMessage message) {
    final token = message.jwt;
    print(token);
    if (token == null) return false;
    try {
      final jwt = JWT.verify(
        token,
        SecretKey(IoC.get<String>(instanceName: 'SecretKey')),
      );
      if (jwt.payload['game_id'] == message.gameId) return true;
      return false;
    } on JWTExpiredException {
      print('jwt expired');
    } on JWTException catch (ex) {
      print(ex.message); // ex: invalid signature
    }
    return false;
  }
}
