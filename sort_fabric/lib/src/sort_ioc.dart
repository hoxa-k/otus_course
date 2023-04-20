class SortIoC
{
  static T resolve<T>(String key, [List<dynamic>? args])
  {
    final result = _map[key];
    if (result == null) throw ArgumentError('no such dependency');
    return result(args) as T;
  }

  static void register<T>(String key, T Function(List<dynamic>? args) dependency) {
    _map[key] = dependency;
  }

  static final _map = {};
}