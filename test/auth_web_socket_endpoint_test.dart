import 'dart:convert';

import 'package:otus_course/auth_service/web_socket_endpoint.dart';
import 'package:otus_course/common_tools/network/web_socket_endpoint.dart';
import 'package:otus_course/auth_service/init_ioc.dart';
import 'package:test/test.dart';
import 'package:web_socket_client/web_socket_client.dart';

void main() {
  final incomingMessageJson = {
    'users': ['user1', 'user2'],
    'action': 'create_game',
  };

  Map<String, String?> incomingMessageJson2(String? gameId) => {
        'user': 'user1',
        'action': 'authenticate',
        'game_id': gameId,
      };

  Map<String, String?> incomingMessageJson3(String? gameId) => {
        'user': 'user25',
        'action': 'authenticate',
        'game_id': gameId,
      };

  late final WebSocketEndpoint endpoint;
  late final WebSocket client;
  late final String gameId;

  setUpAll(() async {
    endpoint = AuthWebSocketEndpoint();

    initAuthIoC();

    client = WebSocket(Uri(
      scheme: 'ws',
      host: endpoint.host,
      port: endpoint.port,
    ));
    await endpoint.start();

    await client.connection.firstWhere((state) => state is Connected);
  });

  tearDownAll(() {
    client.close();
    endpoint.close();
  });

  group('web socket endpoint test', () {
    test('if client send message with users return gameId', () async {
      client.send(jsonEncode(incomingMessageJson));

      final jsonAnswer = jsonDecode(await client.messages.first as String);

      expect(jsonAnswer['game_id'], isNotNull);

      gameId = jsonAnswer['game_id'];
    });
    test('if client send message with user name and gameId return jwt',
        () async {
      client.send(jsonEncode(incomingMessageJson2(gameId)));

      final jsonAnswer = jsonDecode(await client.messages.first as String);

      expect(jsonAnswer['jwt'], isNotNull);
    });
    test('if client send message with user unknown name not return jwt',
        () async {
      client.send(jsonEncode(incomingMessageJson3(gameId)));

      final jsonAnswer = jsonDecode(await client.messages.first as String);

      expect(jsonAnswer['jwt'], isNull);
      expect(jsonAnswer['error'], equals('User not found'));
    });
  });
}
