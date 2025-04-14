import 'package:get/get.dart';
import 'package:getx_patt/app/data/providers/auth_provider.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );

    Get.lazyPut<AuthService>(() => AuthService());
  }
}
