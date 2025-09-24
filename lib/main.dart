import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/bindings/auth_binding.dart';
import 'package:ulangan_flutter/routes/pages.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ulangan_flutter/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
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
      initialRoute: AppRoutes.splashPage,
      getPages: AppPages.pages,
    );
  }
}
