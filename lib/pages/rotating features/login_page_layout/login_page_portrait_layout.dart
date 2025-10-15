import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ulangan_flutter/components/custom_button.dart';
import 'package:ulangan_flutter/components/custom_textfield.dart';
import 'package:ulangan_flutter/components/customcolors.dart';
import 'package:ulangan_flutter/controllers/auth_controllers.dart';

class LoginMobileLayout extends StatelessWidget {
  final AuthController authController;

  const LoginMobileLayout({super.key, required this.authController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Customcolors.bluewidget,
                  radius: 20,
                  child: const Icon(
                    Icons.check_box,
                    color: Customcolors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  "TodyApp",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Customcolors.bluewidget,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Sign in to your\nAccount",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Customcolors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Enter your username and password to log in",
              style: TextStyle(
                fontSize: 14,
                color: Customcolors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: "Username",
              controller: authController.usernameController,
              isPassword: false,
              focusedBorderColor: Customcolors.bluewidget,
            ),
            const SizedBox(height: 12),
            Obx(
              () => CustomTextField(
                label: "Password",
                controller: authController.passwordController,
                isPassword: authController.isPasswordHidden.value,
                showToggle: true,
                onToggle: authController.togglePasswordVisibility,
                focusedBorderColor: Customcolors.bluewidget,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Customcolors.blueaksen),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => CustomButton(
                myText: "Log In",
                isLoading: authController.isLoading.value,
                onPressed: authController.login,
                myTextColor: Customcolors.white,
                backgroundColor: Customcolors.bluewidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
