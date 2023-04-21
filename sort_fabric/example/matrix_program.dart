import 'package:sort_fabric/src/matrix/initialize.dart';
import 'package:sort_fabric/src/matrix_generate_program.dart';

void main(List<dynamic> args) {
  initializeRepository();

  initializeAdapter();

  MatrixGenerateProgram(
    matrixRows: int.parse(args[0]),
    matrixColumns: int.parse(args[1]),
    f0: args[2],
    f1: args[3],
  ).execute();
}
