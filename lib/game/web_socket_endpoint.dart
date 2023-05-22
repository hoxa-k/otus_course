import 'dart:convert';
import 'dart:io';

import 'package:otus_course/game/commands/interpret_command.dart';
import 'package:otus_course/game/commands/interpretable_adapter.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';
import 'package:otus_course/game/models/incoming_message.dart';
import 'package:otus_course/ioc.dart';

class WebSocketEndpoint {
  static const port = 8008;
  static const host = 'localhost';

  int _connectionCount = 0;
  Map<String, WebSocket> _connections = {};

  Future<void> start() async {
    HttpServer server = await HttpServer.bind(host, port);
    server.transform(WebSocketTransformer()).listen(_onWebSocketData);
  }

  void send(String to, String message) {
    _connections[to]?.add(message);
  }

  void _onWebSocketData(WebSocket webSocket) {
    String connectionName = 'connection_$_connectionCount';
    ++_connectionCount;

    _connections.putIfAbsent(connectionName, () => webSocket);

    webSocket
        .map((string) => json.decode(string))
        .listen(_processMessage)
        .onDone(() => _closeConnection(connectionName));
  }

  void _processMessage(dynamic json) {
    final message = IncomingMessage.fromJson(json);
    final gameId = message.gameId;
    final gameQueue = IoC.get<CommandQueue>(param1: gameId);
    gameQueue.putCommand(InterpretCommand(InterpretableAdapter(message)));
  }

  void _closeConnection(String connectionName) {
    if (_connections.containsKey(connectionName)) {
      _connections.remove(connectionName);
    }
  }
}
