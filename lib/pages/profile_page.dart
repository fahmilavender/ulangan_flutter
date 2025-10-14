import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/controllers/layout_controller.dart';
import 'package:ulangan_flutter/pages/rotating%20features/profile_page_layout/profile_landscape_layout.dart';
import 'package:ulangan_flutter/pages/rotating%20features/profile_page_layout/profile_potrait_layout.dart';
import '../components/customcolors.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

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

          return Obx(() => layoutController.isMobile.value
              ? ProfilePortraitLayout()
              : ProfileLandscapeLayout());
        },
      ),
    );
  }
}
