import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/bindings/auth_binding.dart';
import 'package:ulangan_flutter/routes/pages.dart';
import 'package:ulangan_flutter/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: AuthBinding(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.onboardingPage,
      getPages: AppPages.pages,
    );
  }
}