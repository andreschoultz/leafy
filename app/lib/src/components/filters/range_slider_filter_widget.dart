import 'package:flutter/material.dart';
import 'package:leafy_demo/src/utils/extensions/double_extensions.dart';

import 'models/range_slider_toggle_button_model.dart';

class RangeSliderFilter extends StatefulWidget {
  const RangeSliderFilter(
      {super.key,
      required this.headerText,
      required this.measurementUnit,
      required this.rangeMin,
      required this.rangeMax,
      required this.rangeIncrement,
      required this.range,
      required this.onChanged,
      this.toggleButtons});

  final String headerText;
  final String measurementUnit;

  final double rangeMin;
  final double rangeMax;
  final double rangeIncrement;
  final RangeValues range;

  final ValueChanged<RangeValues> onChanged;

  final List<RangeSliderToggleButton>? toggleButtons;

  @override
  State<RangeSliderFilter> createState() => _RangeSliderFilterState();
}

class _RangeSliderFilterState extends State<RangeSliderFilter> {
  @override
  void initState() {
    super.initState();
    _headerText = widget.headerText;
    _measurementUnit = widget.measurementUnit;

    _rangeMin = widget.rangeMin;
    _rangeMax = widget.rangeMax;
    _rangeIncrement = widget.rangeIncrement;
    _range = widget.range;

    _onChanged = widget.onChanged;

    _toggleButtons = getSelectedToggleBtns(widget.toggleButtons ?? [], true);
  }

  late String _headerText;
  late String _measurementUnit;

  late double _rangeMin;
  late double _rangeMax;
  late double _rangeIncrement;
  late RangeValues _range;

  late ValueChanged<RangeValues> _onChanged;

  late List<RangeSliderToggleButton> _toggleButtons;

  late List<Widget> _toggleButtonWidgets = [];

  List<RangeSliderToggleButton> getSelectedToggleBtns(List<RangeSliderToggleButton> toggleButtons, [bool isInitialLoad = false]) {
    if (toggleButtons.isEmpty) return [];

    /* Reset all selections */
    if (!isInitialLoad) {
      for (var x in toggleButtons) {
        x.isSelected = false;
      }
    }

    int isAllIdx = 0;

    /* Find first matching range */
    for (var button in toggleButtons) {
      if (button.isAll) {
        isAllIdx = toggleButtons.indexOf(button);

        continue;
      }

      if (_range.start >= button.from && _range.end <= button.to) {
        button.isSelected = true;

        return toggleButtons;
      }
    }

    /* Default selection if nothing found */
    if (isInitialLoad || (_range.start == _rangeMin && _range.end == _rangeMax)) {
      toggleButtons[isAllIdx].isSelected = true;
    }

    return toggleButtons;
  }

  void onToggleBtnSelected(int idx) {
    setState(() {
      for (var x in _toggleButtons) {
        x.isSelected = false;
      }

      _toggleButtons[idx].isSelected = true;

      final double min = _toggleButtons[idx].isAll ? _rangeMin : _toggleButtons[idx].from;
      final double max = _toggleButtons[idx].isAll ? _rangeMax : _toggleButtons[idx].to;

      _range = RangeValues(min, max);
      _onChanged(_range);
    });
  }

  void onRangeChanged(RangeValues values) {
    setState(() {
      _range = values;
      _toggleButtons = getSelectedToggleBtns(_toggleButtons);
      _onChanged(values);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(text: _headerText),
                  TextSpan(text: ' - ${_range.start.toDisplayString(1)} to ${_range.end.toDisplayString(1)}', style: const TextStyle(fontSize: 18)),
                  TextSpan(text: ' ($_measurementUnit)', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300))
                ],
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  _rangeMin.toDisplayString(),
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  RangeSlider(
                    min: _rangeMin,
                    max: _rangeMax,
                    values: _range,
                    divisions: (_rangeMax * (1 / _rangeIncrement)).round(), // Divides at 0.5
                    onChanged: (RangeValues values) => onRangeChanged(values),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  _rangeMax.toDisplayString(),
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
          ],
        ),
        _toggleButtons.isEmpty
            ? Container()
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ToggleButtons(
                    isSelected: _toggleButtons.map((x) => x.isSelected).toList(),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    /* Constraint for each button, minus a portion of the outer padding (left & right) to ensure a correct fit */
                    onPressed: (index) => onToggleBtnSelected(index),
                    constraints: BoxConstraints.expand(
                        width: (MediaQuery.of(context).size.width / _toggleButtons.length) - ((28 * 2) / _toggleButtons.length)),
                    children: _toggleButtons
                        .map((button) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                              child: Text(button.text, style: const TextStyle(fontSize: 18)),
                            ))
                        .toList(),
                  ),
                ],
              ),
      ],
    );
  }
}
