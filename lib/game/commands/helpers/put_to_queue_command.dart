import 'package:otus_course/game/commands/command_interface.dart';
import 'package:otus_course/game/commnd_queue_interface.dart';

class PutToQueueCommand implements ICommand{
  final CommandQueue queue;
  final ICommand command;
  PutToQueueCommand(this.queue, this.command);

  @override
  void execute() {
    queue.putCommand(command);
  }

}