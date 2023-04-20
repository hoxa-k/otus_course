import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:sort_fabric/src/repository/repository.dart';

class FileRepository implements Repository {
  late final File fileIn;
  late final File fileOut;

  FileRepository({
    required String pathIn,
    required String pathOut,
    FileSystem? fileSystem,
  }) {
    final fs = fileSystem ?? LocalFileSystem();
    fileIn = fs.file(pathIn);
    fileOut = fs.file(pathOut);
    if (!fileIn.existsSync()) throw ArgumentError('file not found');
    if (!fileOut.existsSync()) fileOut.createSync();
  }

  @override
  Future<String> readData() async {
    return await fileIn.readAsString();
  }

  @override
  Future<void> writeData(String data) async {
    await fileOut.writeAsString(data);
  }
}
