import 'package:file/memory.dart';
import 'package:sort_fabric/src/matrix/initialize.dart';
import 'package:sort_fabric/src/matrix/matrix_tools.dart';
import 'package:sort_fabric/src/matrix_generate_program.dart';
import 'package:test/test.dart';

void main() {
  final fileSystem = MemoryFileSystem();
  final fileIn = 'in.txt';
  final fileOut = 'out.txt';
  final matrixRows = 5;
  final matrixColumns = 4;

  Future<void> runTestProgram() async {
    await MatrixGenerateProgram(
      matrixRows: matrixRows,
      matrixColumns: matrixColumns,
      f0: fileIn,
      f1: fileOut,
      fileSystem: fileSystem,
    ).execute();
  }

  setUpAll((){
    initializeRepository();
    initializeAdapter();
  });

  group('matrix program test', () {
    test('input and output files exists', () async {
      await runTestProgram();

      final inputFile = fileSystem.file(fileIn);
      final outputFile = fileSystem.file(fileOut);
      expect(inputFile.existsSync(), true);
      expect(outputFile.existsSync(), true);
    });
    test(
        'input file contains two matrix with '
        'dimensions $matrixRows х $matrixColumns', () async {
      await runTestProgram();

      final inputFile = fileSystem.file(fileIn);

      final generated = inputFile.readAsStringSync().split('\n\n').map((e) {
        return MatrixTools.fromFileFormat(e);
      }).toList();

      expect(generated.length, equals(2));
      expect(generated[0].length, equals(matrixRows));
      expect(generated[1].length, equals(matrixRows));
      expect(generated[0][0].length, equals(matrixColumns));
      expect(generated[1][0].length, equals(matrixColumns));
    });
    test('output is sum of input', () async {
      await runTestProgram();

      final inputFile = fileSystem.file(fileIn);
      final outputFile = fileSystem.file(fileOut);
      final generated = inputFile.readAsStringSync().split('\n\n').map((e) {
        return MatrixTools.fromFileFormat(e);
      }).toList();
      final out = MatrixTools.fromFileFormat(outputFile.readAsStringSync());
      expect(out, equals(MatrixTools.matrixSum(generated[0], generated[1])));
    });
  });
}
