import 'package:get/get.dart';
import 'package:ulangan_flutter/controllers/logout_controller.dart';

class LogoutBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(LogoutController());
  }
  
}