import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../utils/constants/http_constants.dart';
import '../storage/user.dart';
import 'models/responses/authentication_responses.dart';

class APIService {
  final String _BASE_URL = 'https://9fd4-2c0e-7f01-e013-5d00-d90a-3045-e6a9-e5f7.ngrok-free.app'; // TODO: Pull from env
  final _TIMEOUT = const Duration(seconds: 20);

  Future<http.Response> get(String uri, List<String> params, {bool enableRetryOnFail = true, bool enableRetryAuthRefresh = true}) async {
    final headers = await _getRequestHeaders();
    Response response = await http.get(Uri.parse('$_BASE_URL$uri/${params.join('/')}'), headers: headers).timeout(_TIMEOUT);

    /* Auth failed, try to refresh tokens */
    if (enableRetryAuthRefresh && response.statusCode == HttpStatusCode.unauthorized.code) {
      final refreshTokenResponse = await _refreshToken();

      if (refreshTokenResponse.statusCode != HttpStatusCode.ok.code) {
        return refreshTokenResponse;
      }

      return await get(uri, params, enableRetryOnFail: enableRetryOnFail, enableRetryAuthRefresh: false); // Retry with new token
    }

    return response;
  }

  Future<http.Response> post(String uri, Map<String, dynamic> request, {bool enableRetryOnFail = true, bool enableRetryAuthRefresh = true}) async {
    final headers = await _getRequestHeaders();
    Response response = await http.post(Uri.parse('$_BASE_URL$uri'), headers: headers, body: jsonEncode(request)).timeout(_TIMEOUT);

    /* Auth failed, try to refresh tokens */
    if (enableRetryAuthRefresh && response.statusCode == HttpStatusCode.unauthorized.code) {
      final refreshTokenResponse = await _refreshToken();

      if (refreshTokenResponse.statusCode != HttpStatusCode.ok.code) {
        return refreshTokenResponse;
      }

      return await post(uri, request, enableRetryOnFail: enableRetryOnFail, enableRetryAuthRefresh: false); // Retry with new token
    }

    return response;
  }

  Future<http.Response> _refreshToken() async {
    final accessToken = await UserStorage().accessToken.get();
    final refreshToken = await UserStorage().refreshToken.get();

    if (accessToken == null || refreshToken == null) {
      return http.Response('Unauthorized', HttpStatusCode.unauthorized.code);      
    }

    final response = await get('/authenticate/refresh-access-token', [refreshToken, accessToken], enableRetryAuthRefresh: false);

    if (response.statusCode != HttpStatusCode.ok.code) {
      await UserStorage().purge();

      // TODO: Log user out?

      return response;
    }

    final tokens = AuthenticationTokenResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>, response.statusCode);

    await UserStorage().accessToken.set(tokens.accessToken);    
    await UserStorage().refreshToken.set(tokens.refreshToken); 

    return response;
  }

  Future<Map<String, String>> _getRequestHeaders() async {
    final accessToken = await UserStorage().accessToken.get();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    if (accessToken != null) {
      headers.addEntries([MapEntry('Authorization', 'Bearer $accessToken')]);
    }

    return headers;
  }
}