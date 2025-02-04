import 'package:leafy_demo/src/utils/constants/sunlight_intensity_type.dart';

class CheckboxFilterOption {
  CheckboxFilterOption({
    required this.info,
    this.isSelected = false,
  });

  final SunlightIntensityType info;
  bool isSelected;
}
