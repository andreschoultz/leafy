import 'package:flutter/material.dart';
import 'package:leafy_demo/src/screens/plants/filters/models/checkbox_filter_option_model.dart';
import 'package:leafy_demo/src/services/api/models/requests/plant_requests.dart';

class FilterModel extends ChangeNotifier {
  FilterModel();

  RangeFilterStateModel heightRange = RangeFilterStateModel(from: 0, to: 5);
  RangeFilterStateModel diameterRange = RangeFilterStateModel(from: 0, to: 3);

  List<CheckboxFilterOption> sunlight = [];


  void setHeightRange(double from, double to) {
    heightRange.from = from;
    heightRange.to = to;

    notifyListeners();
  }

  void setDiameterRange(double from, double to) {
    diameterRange.from = from;
    diameterRange.to = to;

    notifyListeners();
  }

  PlantListRequest toPlantListRequest() {
    return PlantListRequest(
      filter: PlantFilterRequest(
        height: heightRange.toNumberRangeFilterRequest(),
        diameter: diameterRange.toNumberRangeFilterRequest(),
      ),
    );
  }
}

class RangeFilterStateModel {
  RangeFilterStateModel({required this.from, required this.to});

  double from;
  double to;

  RangeValues toRangeValues() {
    return RangeValues(from, to);
  }

  NumberRangeFilterRequest toNumberRangeFilterRequest() {
    return NumberRangeFilterRequest(from: from, to: to);
  }
}
