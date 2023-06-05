import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class JwtCreator {
  final String privateKey;

  JwtCreator(this.privateKey);

  String generateJwt(dynamic payload) {
    String token;
    final jwt = JWT(payload);

    token = jwt.sign(SecretKey(privateKey));

    return token;
  }
}
