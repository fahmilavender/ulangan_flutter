import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  Future<bool> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Username dan password tidak boleh kosong.');
      return false;
    }

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2));

      if (username == 'admin' && password == 'admin123') {
        Get.snackbar('Sukses', 'Login berhasil!');
        return true;
      } else {
        Get.snackbar('Login Gagal', 'Username atau Password Salah');
        return false;
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
