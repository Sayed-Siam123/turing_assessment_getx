import 'package:get/get.dart';
import 'package:turing_assessment_getx/helper/internet_checker_helper/internet_checker_helper_binding.dart';
import 'package:turing_assessment_getx/modules/dashboard/dashboard_binding.dart';
import 'package:turing_assessment_getx/modules/place_details/place_details_view.dart';
import 'package:turing_assessment_getx/modules/splash/splash_view.dart';

import '../modules/dashboard/dashboard_view.dart';
import '../modules/splash/splash_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      bindings: [
        SplashBinding(),
        InternetCheckerHelperBinding(),
      ]
    ),

    GetPage(
        name: Routes.DASHBOARD,
        page: () => const DashboardPage(),
        bindings: [
          DashboardBinding(),
          InternetCheckerHelperBinding(),
        ]
    ),

    GetPage(
        name: Routes.PLACEDETAILS,
        page: () => const PlaceDetailsPage(),
        bindings: [
          DashboardBinding(),
          InternetCheckerHelperBinding(),
        ]
    ),
  ];
}