import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ulangan_flutter/bindings/add_todo_binding.dart';
import 'package:ulangan_flutter/bindings/auth_binding.dart';
import 'package:ulangan_flutter/pages/add_todo_page.dart';
import 'package:ulangan_flutter/pages/dashboard_page.dart';
import 'package:ulangan_flutter/pages/history_page.dart';
import 'package:ulangan_flutter/pages/home_page.dart';
import 'package:ulangan_flutter/pages/login_page.dart';
import 'package:ulangan_flutter/pages/profile_page.dart';
import 'package:ulangan_flutter/routes/routes.dart';

class AppPages {
    static final pages = [
      GetPage(
      name: AppRoutes.loginPage,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
      GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
      binding: AuthBinding(),
    ),
      GetPage(
      name: AppRoutes.dashboardPage,
      page: () => DashboardPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.addTodo,
      page: () => AddTodoPage(),
      binding: AddTodoBinding(),
    ),
    GetPage(
      name: AppRoutes.historyPage,
      page: () => HistoryPage(),
    ),
    GetPage(
      name: AppRoutes.profilePage, 
      page: () => ProfilePage(),
    ),
    ];
}