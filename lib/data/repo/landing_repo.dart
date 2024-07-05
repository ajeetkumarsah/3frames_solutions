import 'package:get/get.dart';
import 'package:new_app/data/api/api_client.dart';

class LandingRepo {
  final ApiClient apiClient;

  LandingRepo({required this.apiClient});

  Future<Response> getPosts({required String url}) async {
    return await apiClient.getData(url);
  }
}
