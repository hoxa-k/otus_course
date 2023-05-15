import 'package:otus_course/game/commands/control/hard_stop_command.dart';
import 'package:otus_course/game/commands/control/soft_stop_command.dart';
import 'package:otus_course/game/commands/control/start_command.dart';
import 'package:otus_course/game/commands/helpers/print_debug_command.dart';
import 'package:otus_course/game/separate_game_loop.dart';

void main(List<String> arguments) async {
  final loop = SeparateGameLoop();
  await Future.sync(() => StartCommand(loop).execute());
  loop.putCommand(PrintDebugCommand('123'));
  loop.putCommand(PrintDebugCommand('456'));
  loop.putCommand(PrintDebugCommand('789'));
  loop.putCommand(SoftStopCommand(loop));
  loop.putCommand(PrintDebugCommand('111'));
  loop.putCommand(PrintDebugCommand('222'));
  loop.putCommand(PrintDebugCommand('333'));
  await Future.delayed(Duration(seconds: 5));
  loop.putCommand(PrintDebugCommand('444'));
}
