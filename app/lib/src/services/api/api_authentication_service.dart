import 'dart:convert';

import 'package:http/http.dart';
import 'package:leafy_demo/src/services/api/api_service.dart';
import 'package:leafy_demo/src/services/storage/user.dart';

import '../../utils/constants/http_constants.dart';
import 'models/requests/authentication_requests.dart';
import 'models/responses/authentication_responses.dart';
import 'models/responses/common_responses.dart';

class AuthenticationAPIService {
  final String _SUB_URI = '/authenticate';
  final APIService _apiService = APIService();

  Future<CommonMessageResponse> login(String email, String password) async {
    final response = await _apiService.get('$_SUB_URI/login', [email, password]);
      CommonMessageResponse content = CommonMessageResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>, response.statusCode);

    if (response.statusCode != HttpStatusCode.ok.code) {
      return content;
    }

    await _setTokens(response);

    return content;
  }

  Future<CommonMessageResponse> register(String email, String password, String firstName, String? surname) async {
    final request = RegisterUserRequest(
      email: email,
      password: password,
      firstName: firstName,
      surname: surname
    );

    final response = await _apiService.post('$_SUB_URI/register', request.toJsonMap());
    CommonMessageResponse content = CommonMessageResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>, response.statusCode);

    if (response.statusCode != HttpStatusCode.ok.code) {
      return content;
    }

    await _setTokens(response);

    return content;
  }
  
  /* Set access tokens against storage */
  Future<void> _setTokens(Response response) async {
    AuthenticationTokenResponse content = AuthenticationTokenResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>, response.statusCode);

    await UserStorage().accessToken.set(content.accessToken);
    await UserStorage().refreshToken.set(content.refreshToken);
  }
}