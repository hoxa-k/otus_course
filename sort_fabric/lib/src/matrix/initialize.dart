import 'package:sort_fabric/src/matrix/program_interface.dart';
import 'package:sort_fabric/src/matrix_generate_program.dart';
import 'package:sort_fabric/src/repository/file_repository.dart';
import 'package:sort_fabric/src/sort_ioc.dart';

void initializeRepository() {
  SortIoC.register(
    'repository',
    (args) => FileRepository(
      pathIn: args?[0],
      pathOut: args?[1],
      fileSystem: args?[2],
    ),
  );
}

void initializeAdapter() {
  SortIoC.register<ProgramInterface>(
    'Adapter.MatrixSum',
        (args) => MatrixSumAdapter(
      pathIn: args?[0],
      pathOut: args?[1],
      fileSystem: args?[2],
    ),
  );
}
