import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/custom_button.dart';
import 'package:ulangan_flutter/components/custom_textfield.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import 'package:ulangan_flutter/controllers/auth_controllers.dart';
import 'package:ulangan_flutter/routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Customcolors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Customcolors.primary,
                    radius: 20,
                    child: const Icon(Icons.check_box, color: Customcolors.white, size: 20),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 8)),
                  const Text(
                    "TodyApp",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Customcolors.primary,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Sign in to your\nAccount",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Customcolors.textPrimary,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  "Enter your username and password to log in",
                  style: TextStyle(fontSize: 14, color: Customcolors.textSecondary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CustomTextField(
                  label: "Username",
                  controller: authController.usernameController,
                  isPassword: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Obx(
                  () => CustomTextField(
                    label: "Password",
                    controller: authController.passwordController,
                    isPassword: authController.isPasswordHidden.value,
                    showToggle: true,
                    onToggle: authController.togglePasswordVisibility,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Customcolors.primaryLight),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Obx(
                  () => CustomButton(
                    myText: "Log In",
                    isLoading: authController.isLoading.value,
                    onPressed: () async {
                      authController.isLoading.value = true;
                      final success = await authController.login();
                      authController.isLoading.value = false;
                      if (success) Get.offAllNamed(AppRoutes.dashboardPage);
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(child: Divider(thickness: 1, color: Customcolors.divider)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Or"),
                    ),
                    Expanded(child: Divider(thickness: 1, color: Customcolors.divider)),
                  ],
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  side: BorderSide(color: Customcolors.divider),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/google_logo.png',
                      height: 28,
                      width: 28,
                    ),
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    const Text(
                      "Continue with Google",
                      style: TextStyle(color: Customcolors.textPrimary, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    side: BorderSide(color: Customcolors.divider),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.facebook, color: Customcolors.facebook),
                  label: const Text(
                    "Continue with Facebook",
                    style: TextStyle(color: Customcolors.textPrimary, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
