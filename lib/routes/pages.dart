import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ulangan_flutter/pages/add_todo_page.dart';
import 'package:ulangan_flutter/pages/dashboard_page.dart';
import 'package:ulangan_flutter/pages/home_page.dart';
import 'package:ulangan_flutter/pages/login_page.dart';
import 'package:ulangan_flutter/routes/routes.dart';

class AppPages {
    static final pages = [
      GetPage(
      name: AppRoutes.loginPage,
      page: () => LoginPage(),
    ),
      GetPage(
      name: AppRoutes.homePage,
      page: () => HomePage(),
    ),
      GetPage(
      name: AppRoutes.dashboardPage,
      page: () => DashboardPage(),
    ),
    GetPage(
      name: AppRoutes.addTodo,
      page: () => AddTodoPage(),
    ),
    ];
}