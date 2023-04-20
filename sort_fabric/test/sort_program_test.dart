import 'dart:math';

import 'package:file/memory.dart';
import 'package:sort_fabric/sort_fabric.dart';
import 'package:test/test.dart';

void main() {
  final fileSystem = MemoryFileSystem();
  final fileIn = 'in.txt';
  final fileOut = 'out.txt';
  final inputList = List.generate(50, (index) => Random().nextInt(100));
  final orderedInputList = List.from(inputList);
  orderedInputList.sort();

  fileSystem.file(fileIn)
    ..createSync()
    ..writeAsStringSync(inputList.join(';'));

  group('sort program test', () {
    for (final sortMethod in ['selection', 'merge', 'insertion']) {
      test(' selection', () async {
        await SortProgram(
          pathIn: fileIn,
          pathOut: fileOut,
          sortMethod: sortMethod,
          fileSystem: fileSystem,
        ).execute();

        final outputFile = fileSystem.file(fileOut);
        expect(outputFile.existsSync(), true);

        final outputResult = outputFile.readAsStringSync();
        expect(outputResult, contains(sortMethod));
        expect(outputResult, contains(orderedInputList.join(';')));
      });
    }
  });
}
