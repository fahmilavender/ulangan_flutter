import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulangan_flutter/routes/routes.dart';

class LogoutController extends GetxController{
  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("username");
    Get.offAllNamed(AppRoutes.splashPage);
  }
}