import 'package:get/get.dart';
import 'package:getx_patt/app/data/providers/auth_provider.dart';

import '../controllers/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );

    Get.lazyPut<AuthService>(() => AuthService());
  }
}
