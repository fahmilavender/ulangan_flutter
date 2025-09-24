import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulangan_flutter/routes/routes.dart';

class SplashscreenController extends GetxController{
  
    @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  checkLogin()async{
    await Future.delayed(Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString("username") != null){
      Get.offAllNamed(AppRoutes.dashboardPage);
    }else{
      Get.offAllNamed(AppRoutes.loginPage);
    }
  }

}