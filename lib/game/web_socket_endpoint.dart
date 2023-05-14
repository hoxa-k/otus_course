import 'dart:convert';
import 'dart:io';

import 'package:otus_course/game/commands/interpret_command.dart';
import 'package:otus_course/game/commands/interpretable_adapter.dart';
import 'package:otus_course/game/game_loop.dart';
import 'package:otus_course/game/models/incoming_message.dart';
import 'package:otus_course/ioc.dart';

class WebSocketEndpoint {


  static const port = 9223;



  Future<void> start() async{
    HttpServer server = await HttpServer.bind('localhost', port);
    server.transform(WebSocketTransformer()).listen(_onWebSocketData);
  }

  int connectionCount = 0;
  Map<String, WebSocket> connections = {};

  void _onWebSocketData(WebSocket webSocket){
    String connectionName = 'connection_$connectionCount';
    ++connectionCount;

    connections.putIfAbsent(connectionName, () => webSocket);

    webSocket
        .map((string) => json.decode(string))
        .listen((json) {
          final message = IncomingMessage.fromJson(json);
          final gameId = message.gameId;
          final gameThread = IoC.get<GameLoop>(param1: gameId);
          gameThread.putCommand(InterpretCommand(InterpretableAdapter(message)));
    }).onDone(() {
      _closeConnection(connectionName);
    });
  }

  void send(String to, String message) {
    connections[to]?.add(message);
  }

  void _closeConnection(String connectionName) {
    if (connections.containsKey(connectionName)) {
      connections.remove(connectionName);
    }
  }

}