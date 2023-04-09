import 'package:otus_course/game/commands/fueled_interface.dart';
import 'package:otus_course/game/u_object.dart';

class FueledAdapter implements Fueled {
  final UObject object;

  FueledAdapter(this.object);

  @override
  int? getFuelLevel() {
   return object.getProperty('fuel_level');
  }

  @override
  void setFuelLevel(int newLevel) {
    object.setProperty('fuel_level', newLevel);
  }

  @override
  int? getFuelConsumptionVelocity() {
    return object.getProperty('fuel_consumption_velocity');
  }
}
