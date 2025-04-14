import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_patt/app/modules/register/controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Create an Account",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A0DAD)),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                  "Nama Lengkap", Icons.person, controller.nameController),
              _buildTextField(
                  "Username or Email", Icons.email, controller.emailController),
              _buildTextField(
                  "Password", Icons.lock, controller.passwordController,
                  isPassword: true),
              _buildTextField("Confirm Password", Icons.lock,
                  controller.confirmPasswordController,
                  isPassword: true),
              const SizedBox(height: 20),
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (controller.passwordController.text ==
                            controller.confirmPasswordController.text) {
                          controller.register(
                            controller.nameController.text,
                            controller.emailController.text,
                            controller.passwordController.text,
                          );
                        } else {
                          Get.snackbar("Error", "Password tidak cocok!");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A0DAD),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Create Account",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    )),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () => Get.toNamed('/login'),
                child: const Text(
                  "Login Account",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6A0DAD),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF6A0DAD)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF6A0DAD), width: 2),
          ),
        ),
        obscureText: isPassword,
      ),
    );
  }
}
