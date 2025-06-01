import 'dart:convert';

import 'package:leafy_demo/src/services/api/api_service.dart';
import 'package:leafy_demo/src/services/api/models/requests/plant_requests.dart';
import 'package:leafy_demo/src/services/api/models/responses/plant_responses.dart';
import '../../utils/constants/http_constants.dart';

class PlantAPIService {
  final String _SUB_URI = '/plant';
  final APIService _apiService = APIService();

  Future<PlantListResponse> getList(PlantListRequest request) async {
    final response = await _apiService.post('$_SUB_URI/list', request.toJsonMap());
    PlantListResponse content = PlantListResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>, response.statusCode);
    
    if (response.statusCode != HttpStatusCode.ok.code) {
      return content;
    }

    return content;
  }

  Future<PlantResponse> getPlant(String id) async {
    final response = await _apiService.get('$_SUB_URI', [id]);
    PlantResponse content = PlantResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>, response.statusCode);

    if (response.statusCode != HttpStatusCode.ok.code) {
      return content;
    }

    return content;
  }

  Future<AddUserPlantResponse> addUserPlant(String plantId) async {
    final response = await _apiService.get('$_SUB_URI/add', [plantId]);
    AddUserPlantResponse content = AddUserPlantResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>, response.statusCode);

    if (response.statusCode != HttpStatusCode.ok.code) {
      return content;
    }

    return content;
  }
}
