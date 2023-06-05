
class AuthMessage{
  final dynamic Function() incomingMessageProcess;
  AuthMessage(this.incomingMessageProcess);

  dynamic message() {
    return incomingMessageProcess.call();
  }

}