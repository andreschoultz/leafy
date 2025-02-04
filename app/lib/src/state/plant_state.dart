import 'package:flutter/material.dart';
import 'package:leafy_demo/src/services/api/models/responses/plant_responses.dart';
import 'package:leafy_demo/src/state/filter_state.dart';
import 'package:leafy_demo/src/utils/constants/http_constants.dart';

import '../services/api/api_plant_service.dart';
import 'global_state.dart';

class PlantModel extends ChangeNotifier {
  PlantModel({
    required this.globalModel,
    required this.filterModel,
  });

  GlobalModel globalModel;
  FilterModel filterModel;
  PlantListResponse list = PlantListResponse(plants: [], statusCode: HttpStatusCode.badGateway);
  PlantResponse plant = PlantResponse.blank();

  void setModels(GlobalModel globalModel, FilterModel filterModel) {
    this.globalModel = globalModel;
    this.filterModel = filterModel;

    notifyListeners();
  }

  Future<PlantListResponse> getList() async {
    globalModel.setLoading();
    final plantsResult = await PlantAPIService().getList(filterModel.toPlantListRequest());

    if (plantsResult.error()) {
      globalModel.setLoading(value: false);
      globalModel.setError(true, message: plantsResult.message);

      notifyListeners();

      return plantsResult;
    }

    globalModel.setLoading(value: false);
    globalModel.setError(false);
    globalModel.clearMessage();

    list = plantsResult;

    notifyListeners();

    return plantsResult;
  }

  Future<PlantResponse> get(String id) async {
    globalModel.setLoading();
    final plantResult = await PlantAPIService().getPlant(id);

    if (plantResult.error()) {
      globalModel.setLoading(value: false);
      globalModel.setError(true, message: plantResult.message);

      notifyListeners();

      return plantResult;
    }

    globalModel.setLoading(value: false);
    globalModel.setError(false);
    globalModel.clearMessage();

    plant = plantResult;

    notifyListeners();

    return plantResult;
  }

  Future<AddUserPlantResponse> add([String? id]) async {
    globalModel.setLoading();
    final addResult = await PlantAPIService().addUserPlant(id ?? plant.id);

    if (addResult.error()) {
      globalModel.setLoading(value: false);
      globalModel.setError(true, message: addResult.message);

      notifyListeners();

      return addResult;
    }

    globalModel.setLoading(value: false);
    globalModel.setError(false);
    globalModel.clearMessage();

    notifyListeners();

    return addResult;
  }
}
