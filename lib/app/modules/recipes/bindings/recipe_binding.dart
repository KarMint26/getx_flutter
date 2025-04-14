import 'package:get/get.dart';
import 'package:getx_patt/app/data/providers/recipes_provider.dart';

import '../controllers/recipe_controller.dart';

class RecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecipeController>(
      () => RecipeController(),
    );

    Get.lazyPut<RecipeService>(() => RecipeService());
  }
}
