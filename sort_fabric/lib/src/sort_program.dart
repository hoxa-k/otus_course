import 'package:file/file.dart';
import 'package:sort_fabric/src/repository/file_repository.dart';
import 'package:sort_fabric/src/sort/insertion_sort.dart';
import 'package:sort_fabric/src/sort/merge_sort.dart';
import 'package:sort_fabric/src/repository/repository.dart';
import 'package:sort_fabric/src/sort/selection_sort.dart';
import 'package:sort_fabric/src/sort_ioc.dart';
import 'package:sort_fabric/src/sort/sortable.dart';

class SortProgram {
  final String pathIn;
  final String pathOut;
  final String sortMethod;
  final FileSystem? fileSystem;

  SortProgram({
    required this.pathIn,
    required this.pathOut,
    required this.sortMethod,
    this.fileSystem,
  }) {
    _initialize();
  }

  void _initialize() {
    SortIoC.register(
      'repository',
      (args) => FileRepository(
          pathIn: args?[0], pathOut: args?[1], fileSystem: args?[2]),
    );
    SortIoC.register('insertion', (args) => InsertionSort(args?[0]));
    SortIoC.register('merge', (args) => MergeSort(args?[0]));
    SortIoC.register('selection', (args) => SelectionSort(args?[0]));
  }

  Future<void> execute() async {
    final repository = SortIoC.resolve<Repository>(
      'repository',
      [pathIn, pathOut, fileSystem],
    );
    final list = (await repository.readData())
        .split(';')
        .map((e) => int.parse(e))
        .toList();
    final sortable = SortIoC.resolve<Sortable>(sortMethod, [list]);
    final output = sortable.sort();
    await repository.writeData('${sortable.methodName}\n${output.join(';')}');
  }
}
