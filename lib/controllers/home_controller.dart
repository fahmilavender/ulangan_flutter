import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/pages/history_page.dart';
import 'package:ulangan_flutter/pages/home_page.dart';
import 'package:ulangan_flutter/pages/profile_page.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

    final List<Widget> pages = [
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  void changePage(int index) {
    selectedIndex.value = index;
  }
}
  