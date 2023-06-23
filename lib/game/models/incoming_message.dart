import 'package:otus_course/game/u_object.dart';

class IncomingMessage {
  UObject object;

  IncomingMessage(this.object);

  String get gameId => object.getProperty('game_id');
  String get gameObjectId => object.getProperty('game_object_id');
  String get commandId => object.getProperty('command_id');
  String? get jwt => object.getProperty('jwt');
  dynamic get args => object.getProperty('args');

  String get owner => object.getProperty('owner');
  set owner(String owner) {
    object.setProperty('owner', owner);
  }

}
