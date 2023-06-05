import 'package:otus_course/auth_service/init_ioc.dart';
import 'package:otus_course/auth_service/web_socket_endpoint.dart';

void main(List<String> arguments) async {
  initAuthIoC();

  final authWebSocketEndpoint = AuthWebSocketEndpoint();
  await authWebSocketEndpoint.start();
}
