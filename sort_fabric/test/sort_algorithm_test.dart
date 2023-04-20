import 'package:sort_fabric/src/sort/insertion_sort.dart';
import 'package:sort_fabric/src/sort/merge_sort.dart';
import 'package:sort_fabric/src/sort/selection_sort.dart';
import 'package:test/test.dart';

void main() {
  final inputList = [10, 35, 7, 81, 99, 2, 15];
  final expectedList = [2, 7, 10, 15, 35, 81, 99];
  group('sort functions test', () {
    test(' merge', () {
      final resultList = MergeSort(inputList).sort();

      expect(resultList, equals(expectedList));
    });
    test(' insertion', () {
      final resultList = InsertionSort(inputList).sort();

      expect(resultList, equals(expectedList));
    });
  test(' selection', () {
      final resultList = SelectionSort(inputList).sort();

      expect(resultList, equals(expectedList));
    });
  });
}
