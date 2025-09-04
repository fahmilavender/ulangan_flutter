import 'package:get/get.dart';
import 'package:ulangan_flutter/controllers/auth_controllers.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
