import 'package:get/get.dart';
import 'package:getx_patt/app/modules/recipes/bindings/recipe_binding.dart';
import 'package:getx_patt/app/modules/recipes/views/recipe_view.dart';

import 'package:getx_patt/app/modules/home/bindings/home_binding.dart';
import 'package:getx_patt/app/modules/home/views/home_view.dart';
import 'package:getx_patt/app/modules/login/bindings/login_binding.dart';
import 'package:getx_patt/app/modules/login/views/login_view.dart';
import 'package:getx_patt/app/modules/register/bindings/register_binding.dart';
import 'package:getx_patt/app/modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '${_Paths.RECIPE}/:id',
      page: () =>
          RecipeView(recipeId: int.tryParse(Get.parameters['id'] ?? '0') ?? 0),
      binding: RecipeBinding(),
    ),
  ];
}
