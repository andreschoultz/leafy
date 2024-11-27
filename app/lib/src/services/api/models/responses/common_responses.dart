import 'package:leafy_demo/src/utils/constants/http_constants.dart';

class CommonMessageResponse {
  const CommonMessageResponse({
    this.message,
    required this.statusCode,
  });

  final String? message;
  final HttpStatusCode statusCode;
  bool error() => (statusCode == HttpStatusCode.ok || statusCode == HttpStatusCode.created || statusCode == HttpStatusCode.accepted) == false;

  factory CommonMessageResponse.fromJson(Map<String, dynamic> json, int httpStatusCode) {
    return CommonMessageResponse(
      message: json['message'] as String?,
      statusCode: HttpStatusCode.fromCode(httpStatusCode) ?? HttpStatusCode.badRequest,
    );
  }
}
