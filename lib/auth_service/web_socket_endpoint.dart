import 'dart:convert';

import 'package:otus_course/auth_service/commands/auth_message.dart';
import 'package:otus_course/auth_service/models/incoming_message.dart';
import 'package:otus_course/common_tools/network/web_socket_endpoint.dart';
import 'package:otus_course/ioc.dart';

class AuthWebSocketEndpoint extends WebSocketEndpoint {
  @override
  get port => 8009;

  @override
  void processMessage(String connectionName, dynamic json) {
    final message = IncomingMessage.fromJson(json);
    final authMessage = IoC.get<AuthMessage>(
      instanceName: message.action,
      param1: message,
    );
    final answer = authMessage.message();
    send(connectionName, jsonEncode(answer));
  }
}
