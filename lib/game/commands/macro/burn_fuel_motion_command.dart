import 'package:otus_course/game/commands/burn_fuel_command.dart';
import 'package:otus_course/game/commands/check_fuel_command.dart';
import 'package:otus_course/game/commands/fueled_adapter.dart';
import 'package:otus_course/game/commands/macro/macro_command.dart';
import 'package:otus_course/game/commands/movable_adapter.dart';
import 'package:otus_course/game/commands/move_command.dart';
import 'package:otus_course/game/u_object.dart';

class BurnFuelMotionCommand extends MacroCommand {
  BurnFuelMotionCommand(UObject obj)
      : super(
          commandList: [
            CheckFuelCommand(FueledAdapter(obj)),
            MoveCommand(MovableAdapter(obj)),
            BurnFuelCommand(FueledAdapter(obj)),
          ],
        );
}
