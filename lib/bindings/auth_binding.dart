import 'package:get/get.dart';
import 'package:ulangan_flutter/controllers/auth_controllers.dart';
import 'package:ulangan_flutter/controllers/home_controller.dart';
import 'package:ulangan_flutter/controllers/layout_controller.dart';
import 'package:ulangan_flutter/controllers/todo_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.put<TodoController>(TodoController());
    Get.put<HomeController>(HomeController());
    
  }
}
