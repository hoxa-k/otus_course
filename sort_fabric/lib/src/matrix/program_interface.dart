import 'package:file/file.dart';

abstract class ProgramInterface {
  String getPathIn();
  String getPathOut();
  FileSystem? getFileSystem();
}