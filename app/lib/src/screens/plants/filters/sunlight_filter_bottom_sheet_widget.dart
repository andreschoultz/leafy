import 'package:flutter/material.dart';
import 'package:leafy_demo/src/screens/plants/filters/models/checkbox_filter_option_model.dart';
import 'package:leafy_demo/src/utils/constants/sunlight_intensity_type.dart';

class SunlightFilterBottomSheet extends StatefulWidget {
  const SunlightFilterBottomSheet({super.key});

  @override
  State<SunlightFilterBottomSheet> createState() => _SunlightFilterBottomSheetState();
}

class _SunlightFilterBottomSheetState extends State<SunlightFilterBottomSheet> {
  final List<CheckboxFilterOption> _options = [
    CheckboxFilterOption(info: SunlightIntensityType.fullSun),
    CheckboxFilterOption(info: SunlightIntensityType.indirectLight),
    CheckboxFilterOption(info: SunlightIntensityType.partialShade),
    CheckboxFilterOption(info: SunlightIntensityType.lowLight),
  ];

  bool allSelected = false;

  void onOptionSelected(int id, [bool? selected]) {
    setState(() {
      for (var option in _options) {
        if (option.info.id != id) {
          continue;
        }

        option.isSelected = selected ?? !option.isSelected;
      }

      allSelected = _options.every((x) => x.isSelected);
    });
  }

  void onToggleSelectAll([bool? selected]) {
    setState(() {
      allSelected = selected ?? !allSelected;

      for (var option in _options) {
        option.isSelected = allSelected;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.center,
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Sunlight', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            ..._options.map(
              (option) => GestureDetector(
                onTap: () => onOptionSelected(option.info.id),
                child: Row(
                  children: [
                    Checkbox(value: option.isSelected, onChanged: (selected) => onOptionSelected(option.info.id, selected)),
                    Text(
                      option.info.description,
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onToggleSelectAll(),
              child: Row(
                children: [
                  Checkbox(value: allSelected, onChanged: (selected) => onToggleSelectAll(selected)),
                  const Text(
                    'Select All',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(top: 100)),
                Expanded(
                  child: FilledButton(
                    onPressed: () => () => Navigator.pop(context),
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
  }
}
