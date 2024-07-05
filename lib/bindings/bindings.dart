import 'package:get/get.dart';
import 'package:new_app/controller/landing_controller.dart';
import 'package:new_app/data/api/api_client.dart';
import 'package:new_app/data/repo/auth_repository.dart';
import 'package:new_app/data/repo/landing_repo.dart';

import '../controller/auth_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    //Api Client
    Get.lazyPut<ApiClient>(() => ApiClient());
//Repo
    Get.lazyPut<AuthRepo>(() => AuthRepo(apiClient: Get.find()));
    Get.lazyPut<LandingRepo>(() => LandingRepo(apiClient: Get.find()));

    //Controller
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<LandingController>(
        () => LandingController(landingRepo: Get.find()));
  }
}
