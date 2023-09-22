import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/auth_controller.dart';
import '../../root/controllers/root_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {

        Get.put(RootController(), permanent: true);
        Get.put(HomeController(), permanent: true);
        Get.lazyPut<AuthController>(
              () => AuthController(),
        );
  }
}
