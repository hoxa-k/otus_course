import 'package:otus_course/auth_service/auth_controller.dart';
import 'package:otus_course/auth_service/commands/auth_message.dart';
import 'package:otus_course/auth_service/jwt_creator.dart';
import 'package:otus_course/auth_service/models/incoming_message.dart';
import 'package:otus_course/ioc.dart';

void initAuthIoC() {
  IoC.registerSingleton<String>('SecretKey', instanceName: 'SecretKey');
  IoC.registerSingleton<JwtCreator>(
    JwtCreator(IoC.get<String>(instanceName: 'SecretKey')),
  );
  IoC.registerSingleton<AuthController>(AuthController());
  IoC.registerFactoryParam<AuthMessage, IncomingMessage, void>(
        (message, _) => AuthMessage(() =>
        IoC.get<AuthController>().authenticate(message.gameId, message.user)),
    instanceName: 'authenticate',
  );
  IoC.registerFactoryParam<AuthMessage, IncomingMessage, void>(
        (message, _) => AuthMessage(() =>
        IoC.get<AuthController>().createGame(message.users)),
    instanceName: 'create_game',
  );
}
