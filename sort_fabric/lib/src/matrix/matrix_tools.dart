typedef Matrix = List<List<int>>;

class MatrixTools {
  static Matrix fromFileFormat(String matrixStr) {
    Matrix result = List.empty(growable: true);
    final strList = matrixStr.split('\n');
    for (int i = 0; i < strList.length; i++) {
      result.add(strList[i].split(' ').map((e) => int.parse(e)).toList());
    }
    return result;
  }

  static String toFileFormat(Matrix matrix) {
    return matrix.map((e) => e.join(' ')).toList().join('\n');
  }

  static Matrix makeMatrix(rows, cols, function) =>
      Iterable<List<int>>.generate(
              rows,
              (i) =>
                  Iterable<int>.generate(cols, (j) => function(i, j)).toList())
          .toList();

  static Matrix matrixSum(Matrix m1, Matrix m2) {
    assert(
      m1.isNotEmpty &&
          m2.isNotEmpty &&
          m1.length == m2.length &&
          m1[0].length == m2[0].length,
      'wrong input data',
    );

    final mWidth = m1.length;
    final mHeight = m1[0].length;
    Matrix result = List.generate(
      mWidth,
      (i) => List.generate(mHeight, (j) => m1[i][j] + m2[i][j]),
    );
    return result;
  }
}
