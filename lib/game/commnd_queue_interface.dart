import 'package:otus_course/game/commands/command_interface.dart';

abstract class CommandQueue {
  void putCommand(ICommand command);
}