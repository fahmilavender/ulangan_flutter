import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/custom_button.dart';
import 'package:ulangan_flutter/components/custom_textfield.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF24A19C),
                    radius: 20,
                    child: const Icon(Icons.check_box, color: Colors.white, size: 20),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 8)),
                  const Text(
                    "TodyApp",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF24A19C),
                    ),
                  ),
                ],
              ),

              // Title
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Sign in to your\nAccount",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  "Enter your username and password to log in",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),

              // Username
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CustomTextField(
                  label: "Username",
                  controller: authController.usernameController,
                  isPassword: false,
                ),
              ),

              // Password
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

              // Forgot Password
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // forgot password action
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xFF24A19C)),
                    ),
                  ),
                ),
              ),

              // Login Button
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

              // Divider with "Or"
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Or"),
                    ),
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  ],
                ),
              ),

              // Google Login
             // Google Login
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google_logo.png', // pastikan file ada di folder assets
                        height: 28,
                        width: 28,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Continue with Google",
                        style: TextStyle(color: Colors.black87, fontSize: 15),
                      ),
                    ],
                  ),
                ),

              // Facebook Login
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.facebook, color: Colors.blue),
                  label: const Text(
                    "Continue with Facebook",
                    style: TextStyle(color: Colors.black87, fontSize: 15),
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
