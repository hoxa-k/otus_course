import 'package:sort_fabric/src/matrix/matrix_tools.dart';
import 'package:sort_fabric/src/matrix/program_interface.dart';
import 'package:sort_fabric/src/repository/repository.dart';
import 'package:sort_fabric/src/sort_ioc.dart';

class MatrixSumProgram {
  ProgramInterface pInterface;

  MatrixSumProgram(this.pInterface);

  Future<void> execute() async {
    final repository = SortIoC.resolve<Repository>(
      'repository',
      [
        pInterface.getPathIn(),
        pInterface.getPathOut(),
        pInterface.getFileSystem(),
      ],
    );
    final data = await repository.readData();

    final inData = data.split('\n\n');
    if (inData.isEmpty || inData.length != 2) {
      throw ArgumentError('wrong data at input file');
    }
    final m1 = MatrixTools.fromFileFormat(inData[0]);
    final m2 = MatrixTools.fromFileFormat(inData[1]);

    final result = MatrixTools.matrixSum(m1, m2);

    await repository.writeData(MatrixTools.toFileFormat(result));
  }
}
