import 'package:leafy_demo/src/services/api/models/responses/common_responses.dart';

import '../../../../utils/constants/http_constants.dart';

class PlantListItemResponse {
  const PlantListItemResponse({
    required this.id,
    required this.name,
    required this.weeklyWater,
  });

  final String id;
  final String name;
  final int weeklyWater;

  factory PlantListItemResponse.fromJson(Map<String, dynamic> json) {
    return PlantListItemResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      weeklyWater: json['weeklyWater'] as int,
    );
  }
}

class PlantListResponse extends CommonMessageResponse {
  const PlantListResponse({
    required this.plants,
    required super.statusCode,
    super.message,
  });

  final List<PlantListItemResponse> plants;

  factory PlantListResponse.fromJson(Map<String, dynamic> json, int httpStatusCode) {
    return PlantListResponse(
      plants: (json['plants'] as List<dynamic>)
          .map((item) => PlantListItemResponse.fromJson(item as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      statusCode: HttpStatusCode.fromCode(httpStatusCode) ?? HttpStatusCode.badRequest,
    );
  }
}
