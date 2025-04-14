import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_patt/app/modules/login/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Login Account",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A0DAD)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.person, color: Color(0xFF6A0DAD)),
                  hintText: "Username or Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: controller.passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF6A0DAD)),
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A0DAD),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        controller.login(
                          controller.emailController.text,
                          controller.passwordController.text,
                        );
                      },
                      child: const Text("Login",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    )),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Create An Account"),
                  TextButton(
                    onPressed: () => Get.toNamed('/register'),
                    child: const Text("Register",
                        style: TextStyle(color: Color(0xFF6A0DAD))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
