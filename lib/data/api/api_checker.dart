import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      // controller.refreshToken();
    } else {
      // showCustomSnackBar(response.statusText ?? '');
    }
  }
}
