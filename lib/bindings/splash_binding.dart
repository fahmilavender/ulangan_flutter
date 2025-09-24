import 'package:get/get.dart';
import 'package:ulangan_flutter/controllers/splashscreen_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SplashscreenController());
  }
}