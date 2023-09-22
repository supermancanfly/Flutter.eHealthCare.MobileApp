import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../services/auth_service.dart';

class StartMiddleware extends GetMiddleware {
  @override
  RouteSettings redirect(String route) {
    final authService = Get.find<AuthService>();
    if (!authService.isAuth) {
      return RouteSettings(name: Routes.START);
    }
    return null;
  }
}
