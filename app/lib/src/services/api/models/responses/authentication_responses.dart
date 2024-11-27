import 'package:leafy_demo/src/services/api/models/responses/common_responses.dart';

import '../../../../utils/constants/http_constants.dart';

class AuthenticationTokenResponse extends CommonMessageResponse {
  const AuthenticationTokenResponse({
    required this.refreshToken,
    required this.accessToken,
    required super.statusCode,
    super.message
  });

  final String accessToken;
  final String refreshToken;

  factory AuthenticationTokenResponse.fromJson(Map<String, dynamic> json, int httpStatusCode) {

    return AuthenticationTokenResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      message: json['message'] as String?,
      statusCode: HttpStatusCode.fromCode(httpStatusCode) ?? HttpStatusCode.badRequest,
    );
  }
}
