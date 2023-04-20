abstract class Repository {
  Future<String> readData();
  Future<void> writeData(String data);
}