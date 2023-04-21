
import 'package:sort_fabric/src/matrix/matrix_tools.dart';
import 'package:test/test.dart';

void main() {
  final m1 = [[1,2,3], [4,5,6], [7,8,9]];
  final m2 = [[1,2,3], [4,5,4], [3,2,1]];

  test('calculate matrix sum', () {
    final result = MatrixTools.matrixSum(m1, m2);

    expect(result, equals([[2,4,6], [8,10,10], [10,10,10]]));
  });
}