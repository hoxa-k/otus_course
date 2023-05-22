import 'package:otus_course/game/commands/change_velocity_and_rotation_adapter.dart';
import 'package:otus_course/game/commands/change_velocity_command.dart';
import 'package:otus_course/game/commands/macro/macro_command.dart';
import 'package:otus_course/game/commands/rotatable_adapter.dart';
import 'package:otus_course/game/commands/rotate_command.dart';
import 'package:otus_course/game/u_object.dart';

class RotateAndChangeVelocityCommand extends MacroCommand {
  RotateAndChangeVelocityCommand(UObject obj)
      : super(
          commandList: [
            RotateCommand(RotatableAdapter(obj)),
            ChangeVelocityCommand(ChangeVelocityAndRotationAdapter(obj)),
          ],
        );
}
