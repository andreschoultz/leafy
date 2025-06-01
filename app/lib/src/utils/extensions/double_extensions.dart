extension DoubleExtensions on double {
  String toDisplayString([int? precision]) {
    if (round() == this) return round().toString();

    if (precision != null) return toStringAsFixed(precision);

    return toString();
  }
}
