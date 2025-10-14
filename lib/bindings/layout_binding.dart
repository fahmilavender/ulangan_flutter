import 'package:get/get.dart';
import 'package:ulangan_flutter/controllers/layout_controller.dart';

class LayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LayoutController>(LayoutController());
  }
} 