import 'package:location/app/routes/app_routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:location/app/views/home_screen.dart';

import '../bindings/home_binding.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.HOME;
  static final routes = [
    GetPage(name: Routes.HOME, page: () => HomeScreen(), binding: HomeBinding()),
  ];
}