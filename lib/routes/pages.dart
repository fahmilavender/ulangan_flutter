import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ulangan_flutter/pages/login_page.dart';
import 'package:ulangan_flutter/pages/onboarding_page.dart';
import 'package:ulangan_flutter/routes/routes.dart';

class AppPages {
    static final pages = [
      GetPage(
      name: AppRoutes.loginPage,
      page: () => LoginPage(),
    ),
      GetPage(
      name: AppRoutes.onboardingPage,
      page: () => OnboardingPage(),
    ),
    ];
}