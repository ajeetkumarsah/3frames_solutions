part of 'app_pages.dart';

class Routes {
  Routes._();
  static const loginScreen = _Paths.LOGIN;
  static const landingScreen = _Paths.LANDING;
}

abstract class _Paths {
  _Paths._();
  static const LOGIN = '/loginScreen';
  static const LANDING = '/landingScreen';
}
