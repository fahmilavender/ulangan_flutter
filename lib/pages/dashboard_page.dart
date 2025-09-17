import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import 'package:ulangan_flutter/controllers/home_controller.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: homeController.pages[homeController.selectedIndex.value],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: homeController.selectedIndex.value,
          onTap: homeController.changePage,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Customcolors.white, 
          elevation: 8,
          selectedItemColor: Customcolors.bluewidget,
          unselectedItemColor: Customcolors.grey400, 
          selectedFontSize: 13,
          unselectedFontSize: 12,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              activeIcon: Icon(Icons.history),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

