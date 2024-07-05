import 'package:get/get.dart';
import 'package:new_app/bindings/bindings.dart';
import 'package:new_app/view/landing/landing_screen.dart';
import 'package:new_app/view/login/login_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const loginScreen = _Paths.LOGIN;
  static const landingScreen = _Paths.LANDING;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginScreen(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingScreen(),
      binding: HomeBindings(),
    ),
  ];
}
