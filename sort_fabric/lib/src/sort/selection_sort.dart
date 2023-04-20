import 'package:sort_fabric/src/sort/sortable.dart';

class SelectionSort implements Sortable {
  final List<int> list;

  SelectionSort(this.list);

  @override
  List<int> sort() {
    final resultList = List.of(list);

    for (int i = 0; i < resultList.length; i++) {
      var m = i;
      var j = i + 1;
      while (j < resultList.length) {
        if (resultList[j] < resultList[m]) {
          m = j;
        }
        j = j + 1;
      }
      final tmp = resultList[i];
      resultList[i] = resultList[m];
      resultList[m] = tmp;
    }

    return resultList;
  }

  @override
  String get methodName => 'selection';
}
