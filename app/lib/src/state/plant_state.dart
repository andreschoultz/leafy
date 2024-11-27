import 'package:flutter/material.dart';
import 'package:leafy_demo/src/services/api/models/responses/plant_responses.dart';
import 'package:leafy_demo/src/utils/constants/http_constants.dart';

import '../services/api/api_plant_service.dart';
import 'global_state.dart';

class PlantModel extends ChangeNotifier {
  PlantModel({required this.globalModel});

  GlobalModel globalModel;
  PlantListResponse list = PlantListResponse(plants: [], statusCode: HttpStatusCode.badGateway);

  void setGlobalModel(GlobalModel globalModel) {
    this.globalModel = globalModel;

    notifyListeners();
  }

  Future<PlantListResponse> getList() async {
    globalModel.setLoading();
    final plantsResult = await PlantAPIService().getList();

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
}
