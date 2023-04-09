class CommandException implements Exception {
  final String message;

  const CommandException([this.message = ""]);
}
