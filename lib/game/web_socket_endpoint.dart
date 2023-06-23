import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:otus_course/common_tools/network/web_socket_endpoint.dart';
import 'package:otus_course/game/commands/interpret_command.dart';
import 'package:otus_course/game/commands/interpretable_adapter.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/models/incoming_message.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:otus_course/ioc.dart';

class GameWebSocketEndpoint extends WebSocketEndpoint {
  @override
  void processMessage(String connectionName, dynamic json) {
    UObject object = UObject.fromJson(json);
    final message = IncomingMessage(object);
    if (!_checkJwt(IncomingMessage(object))) {
      send(connectionName, 'auth error');
      return;
    }
    final gameId = message.gameId;
    final gameQueue = IoC.get<CommandQueue>(param1: gameId);
    IoC.pushNewScope(init: (ioc) {
      IoC.registerFactoryParam<UObject, String, void>(
        (objId, _) {
          final gameObjects =
              IoC.get<List<UObject>>(instanceName: 'GameObjects');
          return gameObjects.firstWhere(
            (element) =>
                element.getProperty('id') == objId &&
                element.getProperty('owner') == message.owner,
            orElse: () => UObject.empty(),
          );
        },
        instanceName: 'GameObject',
      );
    });
    gameQueue.putCommand(InterpretCommand(InterpretableAdapter(object)));
    IoC.popScope();
  }

  bool _checkJwt(IncomingMessage message) {
    final token = message.jwt;
    if (token == null) return false;
    try {
      final jwt = JWT.verify(
        token,
        SecretKey(IoC.get<String>(instanceName: 'SecretKey')),
      );
      message.owner = jwt.payload['user'];
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
