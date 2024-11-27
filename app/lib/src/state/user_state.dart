import 'package:flutter/material.dart';
import 'package:leafy_demo/src/services/storage/user.dart';

import '../models/state/user_state_model.dart';
import '../services/api/api_authentication_service.dart';
import '../services/api/models/responses/common_responses.dart';
import 'global_state.dart';

class UserModel extends ChangeNotifier {
  UserModel({
    required this.info,
    required this.globalModel,
  });

  UserStateModel info;
  GlobalModel globalModel;

  void setGlobalModel(GlobalModel globalModel) {
    this.globalModel = globalModel;

    notifyListeners();
  }

  Future<CommonMessageResponse> login(String email, String password) async {
    globalModel.setLoading();
    final loginResult = await AuthenticationAPIService().login(email, password);

    if (loginResult.error()) {
      globalModel.setLoading(value: false);
      globalModel.setError(true, message: loginResult.message);

      notifyListeners();

      return loginResult;
    }

    // Call api's here to get user info

    // info = user; // Todo set user info here

    globalModel.setLoading(value: false);
    globalModel.setError(false);
    globalModel.clearMessage();

    notifyListeners();

    return loginResult;
  }

  Future<CommonMessageResponse> register(String email, String firstName, String? surname, String password) async {
    globalModel.setLoading();
    final registerResult = await AuthenticationAPIService().register(email, password, firstName, surname);

    if (registerResult.error()) {
      globalModel.setLoading(value: false);
      globalModel.setError(true, message: registerResult.message);

      notifyListeners();

      return registerResult;
    }

    globalModel.setLoading(value: false);
    globalModel.setError(false);
    globalModel.clearMessage();

    notifyListeners();

    return registerResult;
  }

  Future<void> logout() async {
    globalModel.setLoading();

    await UserStorage().purge();

    globalModel.setLoading(value: false);
    globalModel.setError(false);
    globalModel.clearMessage();

    notifyListeners();
  }
}
