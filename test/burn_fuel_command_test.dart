import 'package:otus_course/game/commands/burn_fuel_command.dart';
import 'package:otus_course/game/commands/fueled_adapter.dart';
import 'package:otus_course/game/u_object.dart';
import 'package:test/test.dart';

void main() {
  test('burn fuel command test', () {
    final gameObject = UObject();
    gameObject.setProperty('fuel_level', 8);
    gameObject.setProperty('fuel_consumption_velocity', 1);

    BurnFuelCommand(FueledAdapter(gameObject)).execute();

    expect(gameObject.getProperty('fuel_level'), 7);
  });

  test('burn fuel command test if no fuel', () {
    final gameObject = UObject();
    gameObject.setProperty('fuel_consumption_velocity', 1);

    expect(() => BurnFuelCommand(FueledAdapter(gameObject)).execute(), throwsArgumentError);
  });

  test('burn fuel command test if no fuel consumption velocity', () {
    final gameObject = UObject();
    gameObject.setProperty('fuel_level', 1);

    expect(() => BurnFuelCommand(FueledAdapter(gameObject)).execute(), throwsArgumentError);
  });
}
