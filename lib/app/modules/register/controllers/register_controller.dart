import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_patt/app/data/providers/auth_provider.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  var isAuthenticated = false.obs;

  final authService = Get.find<AuthService>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> register(String name, String email, String password) async {
    isLoading.value = true;

    bool success =
        await authService.register(Get.context!, name, email, password);

    isLoading.value = false;

    if (success) {
      Get.snackbar("Success", "Registrasi berhasil! Silakan login.");
      Get.offAllNamed('/login');
    } else {
      Get.snackbar("Error", "Registrasi gagal, coba lagi nanti");
    }
  }
}
