import 'dart:math';

import 'package:file/file.dart';
import 'package:sort_fabric/src/matrix/matrix_tools.dart';
import 'package:sort_fabric/src/matrix/program_interface.dart';
import 'package:sort_fabric/src/matrix_sum_program.dart';
import 'package:sort_fabric/src/repository/repository.dart';
import 'package:sort_fabric/src/sort_ioc.dart';

class MatrixGenerateProgram {
  final String f0;
  final String f1;
  final FileSystem? fileSystem;
  final int matrixRows;
  final int matrixColumns;

  MatrixGenerateProgram({
    required this.matrixRows,
    required this.matrixColumns,
    required this.f0,
    required this.f1,
    this.fileSystem,
  });

  Future<void> execute() async {
    final repository = SortIoC.resolve<Repository>(
      'repository',
      [f0, f0, fileSystem],
    );

    final matrixSumAdapter = SortIoC.resolve<ProgramInterface>(
      'Adapter.MatrixSum',
      [f0, f1, fileSystem],
    );

    final List<String> result = List.generate(2, (index) {
      return MatrixTools.toFileFormat(MatrixTools.makeMatrix(
        matrixRows,
        matrixColumns,
        (i, j) => Random().nextInt(100),
      ));
    });

    await repository.writeData(result.join('\n\n'));

    await MatrixSumProgram(matrixSumAdapter).execute();
  }
}

class MatrixSumAdapter implements ProgramInterface {
  final FileSystem? fileSystem;
  final String pathIn;
  final String pathOut;

  MatrixSumAdapter({
    required this.pathIn,
    required this.pathOut,
    this.fileSystem,
  });

  @override
  FileSystem? getFileSystem() => fileSystem;

  @override
  String getPathIn() => pathIn;

  @override
  String getPathOut() => pathOut;

}
