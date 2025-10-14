import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/controllers/layout_controller.dart';
import 'package:ulangan_flutter/pages/rotating%20features/home_page_layout/home_landscape_layout.dart';
import 'package:ulangan_flutter/pages/rotating%20features/home_page_layout/home_potrait_layout.dart';
import '../components/customFABbutton.dart';
import '../components/customcolors.dart';
import '../routes/routes.dart';
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final LayoutController layoutController = Get.find<LayoutController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Customcolors.bghome,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobileNow = constraints.maxWidth < 640;
          if (layoutController.isMobile.value != isMobileNow) {
            layoutController.isMobile.value = isMobileNow;
          }

          return Stack(
            children: [
              Obx(() => layoutController.isMobile.value
                  ? HomePortraitLayout()
                  : HomeLandscapeLayout()),

              Positioned(
                bottom: 20,
                right: 20,
                child: CustomFabButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.addTodo);
                  },
                  backgroundColor: Customcolors.bluewidget,
                  icon: Icons.add,
                  iconColor: Customcolors.white,
                  size: 56,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
