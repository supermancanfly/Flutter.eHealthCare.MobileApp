import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../controllers/auth_controller.dart';
import 'package:provider/provider.dart';
import '../controllers/google_controller.dart';
import '../../global_widgets/circular_loading_widget.dart';

class StartView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    controller.loginFormKey = new GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        body: Form(
          key: controller.loginFormKey,
          child: ListView(
            primary: true,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Obx(() {
                    if (controller.loading.isTrue)
                      return CircularLoadingWidget(height: 300);
                    else {
                      return Container(
                        width: Get.width,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(50, 200, 50, 0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/icon/icon.png',
                              ),
                              SizedBox(height: 50),
                              MaterialButton(
                                onPressed: () {
                                  Get.toNamed(Routes.LOGIN);
                                },
                                color: Colors.yellow,
                                minWidth: 250,
                                height: 50,
                                elevation: 10,
                                child: Wrap(
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Login".tr,
                                      style: Get.textTheme.subtitle1.merge(
                                          TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                    ),
                                  ],
                                ),
                                shape: StadiumBorder(),
                              ),
                              SizedBox(height: 50),
                              MaterialButton(
                                onPressed: () {
                                  Get.toNamed(Routes.REGISTER);
                                },
                                color: Colors.purple,
                                minWidth: 250,
                                height: 50,
                                elevation: 10,
                                child: Wrap(
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  spacing: 10,
                                  children: [
                                    Text(
                                      "Create Account".tr,
                                      style: Get.textTheme.subtitle1.merge(
                                          TextStyle(
                                              color: Colors.white,
                                              fontSize: 19)),
                                    ),
                                  ],
                                ),
                                shape: StadiumBorder(),
                              ),
                              SizedBox(height: 50),
                              // MaterialButton(
                              //   onPressed: () {
                              //     final provider =
                              //     Provider.of<GoogleSignInProvider>(
                              //         context,
                              //         listen: false);
                              //     provider.googleLogin();
                              //   },
                              //   color: Colors.red,
                              //   minWidth: 250,
                              //   height: 50,
                              //   elevation: 10,
                              //
                              //   child: Wrap(
                              //     runAlignment: WrapAlignment.center,
                              //     crossAxisAlignment: WrapCrossAlignment.center,
                              //     spacing: 10,
                              //     children: [
                              //       Text(
                              //         "Continue with Google".tr,
                              //         style: Get.textTheme.subtitle1.merge(
                              //             TextStyle(
                              //                 color: Colors.white, fontSize: 18)),
                              //       ),
                              //     ],
                              //   ),
                              //   shape: StadiumBorder(),
                              // ),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        final provider =
                                            Provider.of<GoogleSignInProvider>(
                                                context,
                                                listen: false);
                                        provider.googleLogin();
                                      },
                                      child: Image.asset(
                                        "assets/icon/google.png",
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.loginWithFacebook();
                                      },
                                      child: Image.asset(
                                        "assets/icon/facebook.png",
                                        height: 100,
                                      ),
                                    ),
                                  ),
                                ],
                                //
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
