import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/controllers/auth_controllers.dart';
import 'package:ulangan_flutter/controllers/layout_controller.dart';
import 'package:ulangan_flutter/pages/rotating%20features/login_page_layout/login_page_landscape_layout.dart';
import 'package:ulangan_flutter/pages/rotating%20features/login_page_layout/login_page_portrait_layout.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final AuthController authController = Get.put(AuthController());
  final LayoutController layoutController = Get.put(LayoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          layoutController.updateLayout(constraints);
          return Obx(() {
            return layoutController.isMobile.value
                ? LoginMobileLayout(authController: authController)
                : LoginWidescreenLayout(authController: authController);
          });
        },
      ),
    );
  }
}
