import 'dart:math';

class Equation {
  static const eps = 0.001;
  static const nonNumberValues = [
    double.infinity,
    double.nan,
    double.negativeInfinity
  ];

  static List<double> solve(double a, double b, double c) {
    if (a.isNaN ||
        a.isInfinite ||
        b.isNaN ||
        b.isInfinite ||
        c.isNaN ||
        c.isInfinite) throw ArgumentError('argument not a number');

    if (a.abs() < eps) throw ArgumentError('a cannot be null');

    final D = b * b - 4 * a * c;

    if (D.abs() < eps) return [-b / (2 * a), -b / (2 * a)];

    if (D > 0) {
      return [(-b + sqrt(D)) / (2 * a), (-b - sqrt(D)) / (2 * a)];
    } else {
      return <double>[];
    }
  }
}
