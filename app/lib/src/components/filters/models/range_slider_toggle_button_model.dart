class RangeSliderToggleButton {
  RangeSliderToggleButton({
    required this.text,
    this.from = 0,
    this.to = 0,
    this.isAll = false,
    this.isSelected = false,
  });

  final String text;
  final double from;
  final double to;
  final bool isAll;

  bool isSelected = false;
}