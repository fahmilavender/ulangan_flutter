import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/customButton.dart';
import 'package:ulangan_flutter/components/customTextField.dart';
import 'package:ulangan_flutter/controllers/auth_controllers.dart';

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
      appBar: AppBar(title: const Text("Login Page")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Welcome to our application",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text("Please fill username and password below"),
              const SizedBox(height: 30),

              CustomTextField(
                label: "Username",
                controller: authController.usernameController,
                isPassword: false,
              ),

              Obx(() => CustomTextField(
                    label: "Password",
                    controller: authController.passwordController,
                    isPassword: authController.isPasswordHidden.value,
                    showToggle: true,
                    onToggle: authController.togglePasswordVisibility,
                  )),
              const SizedBox(height: 30),

              Obx(() => SizedBox(
                    width: double.infinity,
                    child: authController.isLoading.value
                        ? const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Color(0xFF24A19C),
                                strokeWidth: 3,
                              ),
                            ),
                          )
                        : CustomButton(
                            mytext: "Login",
                            onPressed: () async {
                              await authController.login();
                            },
                          ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}