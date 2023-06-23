class UObject {
  late final Map<String, dynamic> _properties;

  UObject() : _properties = {};

  UObject._(Map<String, dynamic> json) : _properties = json;

  factory UObject.fromJson(Map<String, dynamic> json) => UObject._(json);

  factory UObject.empty() => UObject();

  bool get isEmpty => _properties.isEmpty;

  dynamic getProperty(String key) {
    return _properties[key];
  }

  void setProperty(String key, dynamic value) {
    _properties[key] = value;
  }
}
