import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_patt/app/data/providers/auth_provider.dart';
import 'package:getx_patt/app/data/providers/recipes_provider.dart';

class HomeController extends GetxController {
  var recipes = [].obs;
  var isLoading = false.obs;
  // final RecipeService _recipeServices = RecipeService();
  // final AuthService _authService = AuthService();
  final _recipeServices = Get.find<RecipeService>();
  final _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  void fetchRecipes() async {
    isLoading.value = true;
    var data = await _recipeServices.getAllRecipe();
    recipes.value = data;
    isLoading.value = false;
  }

  void confirmLogout() {
    Get.defaultDialog(
      title: "Konfirmasi Logout",
      middleText: "Apakah Anda yakin ingin keluar?",
      textCancel: "Batal",
      textConfirm: "Logout",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await _authService.logout();
        Get.offAllNamed('/login');
      },
    );
  }
}
