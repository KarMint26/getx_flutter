import 'package:get/get.dart';
import 'package:getx_patt/app/data/providers/auth_provider.dart';
import 'package:getx_patt/app/data/providers/recipes_provider.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    Get.lazyPut<RecipeService>(() => RecipeService());

    Get.lazyPut<AuthService>(() => AuthService());
  }
}
