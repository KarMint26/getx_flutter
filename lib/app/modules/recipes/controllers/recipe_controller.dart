import 'package:get/get.dart';
import 'package:getx_patt/app/data/providers/recipes_provider.dart';

class RecipeController extends GetxController {
  var recipeDetail = {}.obs;
  var isLoading = false.obs;
  final _recipeServices = Get.find<RecipeService>();

  void fetchRecipeById(int id) async {
    isLoading.value = true;
    var data = await _recipeServices.getRecipeById(id);
    if (data != null) {
      recipeDetail.value = data;
    } else {
      Get.snackbar("Error", "Failed to load recipe details.");
    }
    isLoading.value = false;
  }
}
