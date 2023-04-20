import 'package:sort_fabric/src/sort/sortable.dart';

class MergeSort implements Sortable {
  final List<int> list;

  MergeSort(this.list);

  @override
  List<int> sort() {
    final resultList = List.of(list);
    return mergeSort(resultList);
  }

  List<int> merge(List<int> left, List<int> right) {
    List<int> arr = [];
    while (left.isNotEmpty && right.isNotEmpty) {
      if (left[0] < right[0]) {
        arr.add(left.removeAt(0));
      } else {
        arr.add(right.removeAt(0));
      }
    }

    return arr
      ..addAll(left)
      ..addAll(right);
  }

  List<int> mergeSort(List<int> list) {
    if (list.length < 2) {
      return list;
    }

    final half = (list.length / 2).round();
    final left = list.sublist(0, half);
    list.removeRange(0, half);
    // запускаем рекурсию и отдаём ей правую и левую части массива
    return merge(mergeSort(left), mergeSort(list));
  }

  @override
  String get methodName => 'merge';
}
