import 'package:flutter/material.dart';
import 'package:leafy_demo/src/components/filters/models/range_slider_toggle_button_model.dart';
import 'package:leafy_demo/src/components/filters/range_slider_filter_widget.dart';
import 'package:leafy_demo/src/state/filter_state.dart';
import 'package:provider/provider.dart';

class SizeFilterBottomSheet extends StatefulWidget {
  const SizeFilterBottomSheet({
    super.key,
    required this.onApply,
  });

  final Function onApply;

  @override
  State<SizeFilterBottomSheet> createState() => _SizeFilterBottomSheetState();
}

class _SizeFilterBottomSheetState extends State<SizeFilterBottomSheet> {
  final List<RangeSliderToggleButton> _toggleHeightButtons = [
    RangeSliderToggleButton(text: 'Any', isAll: true),
    RangeSliderToggleButton(text: 'Desk', from: 0, to: 0.4),
    RangeSliderToggleButton(text: 'Indoor', from: 0.4, to: 1),
    RangeSliderToggleButton(text: 'Patio', from: 1, to: 1.6),
    RangeSliderToggleButton(text: 'Garden', from: 1.6, to: 5),
  ];

  final List<RangeSliderToggleButton> _toggleDiameterButtons = [
    RangeSliderToggleButton(text: 'Any', isAll: true),
    RangeSliderToggleButton(text: 'Desk', from: 0, to: 0.3),
    RangeSliderToggleButton(text: 'Indoor', from: 0.3, to: 0.8),
    RangeSliderToggleButton(text: 'Patio', from: 0.8, to: 1.2),
    RangeSliderToggleButton(text: 'Garden', from: 1.2, to: 3),
  ];

  late RangeValues heightRange;
  late RangeValues diameterRange;

  @override
  void initState() {
    heightRange = Provider.of<FilterModel>(context, listen: false).heightRange.toRangeValues();
    diameterRange = Provider.of<FilterModel>(context, listen: false).diameterRange.toRangeValues();
    
    super.initState();
  }

  Future<void> onApply() async {
    Provider.of<FilterModel>(context, listen: false).setHeightRange(heightRange.start, heightRange.end);
    Provider.of<FilterModel>(context, listen: false).setDiameterRange(diameterRange.start, diameterRange.end);
    
    if (!mounted) {
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterModel>(builder: (_, filterModel, __) {
      return Container(
        height: 400,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.center,
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RangeSliderFilter(
                headerText: 'Diameter',
                measurementUnit: 'meters',
                rangeMin: 0,
                rangeMax: 3,
                rangeIncrement: 0.3,
                range: RangeValues(filterModel.diameterRange.from, filterModel.diameterRange.to),
                onChanged: (RangeValues values) {
                  diameterRange = values;
                },
                toggleButtons: _toggleDiameterButtons,
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              RangeSliderFilter(
                headerText: 'Height',
                measurementUnit: 'meters',
                rangeMin: 0,
                rangeMax: 5,
                rangeIncrement: 0.5,
                range: RangeValues(filterModel.heightRange.from, filterModel.heightRange.to),
                onChanged: (RangeValues values) {
                  heightRange = values;
                },
                toggleButtons: _toggleHeightButtons,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 100)),
                  Expanded(
                    child: FilledButton(
                      onPressed: onApply,
                      style: ButtonStyle(padding: WidgetStateProperty.all<EdgeInsets>(const EdgeInsets.all(14))),
                      child: const Text('Apply', style: TextStyle(fontSize: 24)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
