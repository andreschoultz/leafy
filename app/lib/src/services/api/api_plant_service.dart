import 'dart:convert';

import 'package:leafy_demo/src/services/api/api_service.dart';
import 'package:leafy_demo/src/services/api/models/responses/plant_responses.dart';
import '../../utils/constants/http_constants.dart';

class PlantAPIService {
  final String _SUB_URI = '/plant';
  final APIService _apiService = APIService();

  Future<PlantListResponse> getList() async {
    final response = await _apiService.get('$_SUB_URI/list', []);
    PlantListResponse content = PlantListResponse.fromJson(jsonDecode(response.body) as Map<String, dynamic>, response.statusCode);
    
    if (response.statusCode != HttpStatusCode.ok.code) {

      return content;
    }

    return content;
  }
}
