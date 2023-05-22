import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/startable_queue_interface.dart';

class StartCommand implements ICommand {
  final StartableQueue queue;

  StartCommand(this.queue);

  @override
  void execute() {
    queue.start();
  }
}
