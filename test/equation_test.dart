import 'package:otus_course/utils/equation.dart';
import 'package:test/test.dart';

void main() {
  test('нет корней', () {
    expect(Equation.solve(1, 0, 1), []);
  });

  test('два корня кратности 1 ', () {
    expect(Equation.solve(1, 0, -1), [1, -1]);
  });

  test('есть один корень кратности 2', () {
    expect(Equation.solve(1, 2, 1), [-1, -1]);
  });

  test('коэффициент a не может быть равен 0, выдать exception', () {
    expect(
      () => Equation.solve(0, 2, 1),
      throwsA(
        predicate(
          (e) => e is ArgumentError && e.message == 'a cannot be null',
        ),
      ),
    );
  });

  test('есть один корень кратности 2, дискриминант меньше eps', () {
    expect(Equation.solve(1, 2, 0.999975), [-1, -1]);
  });

  group('коэффициенты не могут принимать не числовые значения, ', () {
    for (final notNum in [
      double.infinity,
      double.nan,
      double.negativeInfinity
    ]) {
      test('коэффициент a - выдать exception', () {
        expect(
          () => Equation.solve(notNum, 2, 1),
          throwsA(
            predicate(
              (e) => e is ArgumentError && e.message == 'argument not a number',
            ),
          ),
        );
      });
      test('коэффициент b - выдать exception', () {
        expect(
          () => Equation.solve(2, notNum, 1),
          throwsA(
            predicate(
              (e) => e is ArgumentError && e.message == 'argument not a number',
            ),
          ),
        );
      });
      test('коэффициент c - выдать exception', () {
        expect(
          () => Equation.solve(2, 2, notNum),
          throwsA(
            predicate(
              (e) => e is ArgumentError && e.message == 'argument not a number',
            ),
          ),
        );
      });
    }
  });
}
