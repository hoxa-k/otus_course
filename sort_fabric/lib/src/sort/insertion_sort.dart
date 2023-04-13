import 'sortable.dart';

class InsertionSort implements Sortable {
  final List<int> list;

  InsertionSort(this.list);

  @override
  List<int> sort() {
    final resultList = List.of(list);
    for (int i = 1; i < resultList.length; i++) {
      for (int j = i; j > 0 && resultList[j - 1] > resultList[j]; j--) {
        final tmp = resultList[j - 1];
        resultList[j - 1] = resultList[j];
        resultList[j] = tmp;
      }
    }
    return resultList;
  }

  @override
  String get methodName => 'insertion';
}
