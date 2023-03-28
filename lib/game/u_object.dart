class UObject {
  final Map<String, dynamic> _properties = {};
  dynamic getProperty(String key){
    return _properties[key];
  }

  void setProperty(String key, dynamic value){
    _properties[key] = value;
  }
}