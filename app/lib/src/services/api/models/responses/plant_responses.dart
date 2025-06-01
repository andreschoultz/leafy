import 'package:leafy_demo/src/services/api/models/responses/common_responses.dart';

import '../../../../utils/constants/http_constants.dart';

class PlantListItemResponse {
  const PlantListItemResponse({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.weeklyWater,
  });

  final String id;
  final String name;
  final String imageURL;
  final int weeklyWater;

  factory PlantListItemResponse.fromJson(Map<String, dynamic> json) {
    return PlantListItemResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      imageURL: json['imageURL'] as String,
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
      plants: (json['plants'] as List<dynamic>).map((item) => PlantListItemResponse.fromJson(item as Map<String, dynamic>)).toList(),
      message: json['message'] as String?,
      statusCode: HttpStatusCode.fromCode(httpStatusCode) ?? HttpStatusCode.badRequest,
    );
  }
}

class PlantResponse extends CommonMessageResponse {
  const PlantResponse(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageURL,
      required this.idealHumidityPerc,
      required this.avgHeight,
      required this.avgDiameter,
      required this.idealSunlightK,
      required this.weeklyWater,
      required this.userHasPlant,
      required this.tags,
      required super.statusCode,
      super.message});

  final String id;
  final String name;
  final String description;
  final String imageURL;
  final double idealHumidityPerc;
  final double avgHeight;
  final double avgDiameter;
  final double idealSunlightK;
  final int weeklyWater;
  final bool userHasPlant;
  final List<PlantResponseTag> tags;

  factory PlantResponse.fromJson(Map<String, dynamic> json, int httpStatusCode) {
    return PlantResponse(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageURL: json['imageURL'] as String,
      idealHumidityPerc: double.parse(json['idealHumidityPerc'] as String),
      avgHeight: double.parse(json['avgHeight'] as String),
      avgDiameter: double.parse(json['avgDiameter'] as String),
      idealSunlightK: double.parse(json['idealSunlightK'] as String),
      weeklyWater: json['weeklyWater'] as int,
      userHasPlant: json['userHasPlant'] as bool,
      tags: (json['tags'] as List<dynamic>).map((item) => PlantResponseTag.fromJson(item as Map<String, dynamic>)).toList(),
      message: json['message'] as String?,
      statusCode: HttpStatusCode.fromCode(httpStatusCode) ?? HttpStatusCode.badRequest,
    );
  }

  factory PlantResponse.blank() {
    return const PlantResponse(
      id: '',
      name: '',
      description: '',
      imageURL: '',
      idealHumidityPerc: 0,
      avgHeight: 0,
      avgDiameter: 0,
      idealSunlightK: 0,
      weeklyWater: 0,
      userHasPlant: false,
      tags: [],
      statusCode: HttpStatusCode.badRequest,
    );
  }
}

class PlantResponseTag {
  const PlantResponseTag({
    required this.tagId,
    required this.name,
  });

  final String tagId;
  final String name;

  factory PlantResponseTag.fromJson(Map<String, dynamic> json) {
    return PlantResponseTag(
      tagId: json['tagId'] as String,
      name: json['name'] as String,
    );
  }
}

class AddUserPlantResponse extends CommonMessageResponse {
  const AddUserPlantResponse({
    required this.id,
    required super.statusCode,
    super.message,
  });

  final String id;

  factory AddUserPlantResponse.fromJson(Map<String, dynamic> json, int httpStatusCode) {
    return AddUserPlantResponse(
      id: json['id'] as String,
      message: json['message'] as String?,
      statusCode: HttpStatusCode.fromCode(httpStatusCode) ?? HttpStatusCode.badRequest,
    );
  }
}
