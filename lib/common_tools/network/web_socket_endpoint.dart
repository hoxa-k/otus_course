import 'dart:convert';
import 'dart:io';

abstract class WebSocketEndpoint {
  final port = 8008;
  final host = 'localhost';

  int _connectionCount = 0;
  final Map<String, WebSocket> _connections = {};
  late final HttpServer _server;

  Future<void> start() async {
    _server = await HttpServer.bind(host, port);
    _server.transform(WebSocketTransformer()).listen(_onWebSocketData);
  }

  void send(String to, String? message) {
    _connections[to]?.add(message);
  }

  void _onWebSocketData(WebSocket webSocket) {
    String connectionName = 'connection_$_connectionCount';
    ++_connectionCount;

    _connections.putIfAbsent(connectionName, () => webSocket);

    webSocket
        .map((string) => json.decode(string))
        .listen((json) => processMessage(connectionName, json))
        .onDone(() => _closeConnection(connectionName));
  }

  void processMessage(String connectionName, dynamic json);

  void _closeConnection(String connectionName) async {
    if (_connections.containsKey(connectionName)) {
      _connections.remove(connectionName);
    }
  }

  void close() async {
    for (var webSocket in _connections.values) {
      await webSocket.close();
    }
    await _server.close();
  }
}
