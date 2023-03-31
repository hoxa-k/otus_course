import 'package:otus_course/game/exceptions/command_exception.dart';
import 'package:otus_course/game/commands/check_fuel_command.dart';
import 'package:otus_course/game/commands/fueled_adapter.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:test/test.dart';

void main() {
  test('check fuel command test', () {
    final gameObject = UObject();
    gameObject.setProperty('fuel_level', 8);

    expect(
      () => CheckFuelCommand(FueledAdapter(gameObject)).execute(),
      isNot(throwsArgumentError),
    );
  });

  test('check fuel command test throws CommandException if fuel 0 or less', () {
    final gameObject = UObject();
    gameObject.setProperty('fuel_level', 0);

    expect(
      () => CheckFuelCommand(FueledAdapter(gameObject)).execute(),
      throwsA(isA<CommandException>()),
    );
  });

  test('check fuel command test throws exception if fuel not set', () {
    final gameObject = UObject();

    expect(
      () => CheckFuelCommand(FueledAdapter(gameObject)).execute(),
      throwsArgumentError,
    );
  });
}
