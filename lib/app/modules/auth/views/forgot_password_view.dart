import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/setting_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordView extends GetView<AuthController> {
  final Setting _settings = Get.find<SettingsService>().setting.value;

  @override
  Widget build(BuildContext context) {
    controller.forgotPasswordFormKey = new GlobalKey<FormState>();

    return Scaffold(
        body: Form(
          key: controller.forgotPasswordFormKey,
          child: ListView(
            primary: true,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                Container(
                height: 180,
                width: Get.width,
                margin: EdgeInsets.only(bottom: 100),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 100, 50, 0),
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Image.asset(
                        'assets/icon/icon.png',
                      ),
                      // Text("Fill the following credentials to login your account", style: Get.textTheme.caption.merge(TextStyle(color: Get.theme.primaryColor))),
                    ],
                  ),
                ),
              ),
                ],
              ),
              Obx(() {
                if (controller.loading.isFalse){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFieldWidget(
                        labelText: "Email Address".tr,
                        hintText: "johndoe@gmail.com".tr,
                        initialValue: controller.currentUser?.value?.email,
                        onSaved: (input) => controller.currentUser.value.email = input,
                        validator: (input) => !GetUtils.isEmail(input) ? "Should be a valid email".tr : null,
                        iconData: Icons.alternate_email,
                      ),

                      BlockButtonWidget(
                        onPressed: controller.send_random_number,
                        color: Colors.red[400],
                        text: Text(
                          "Send Reset Link".tr,
                          style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor)),
                        ),
                      ).paddingSymmetric(vertical: 35, horizontal: 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.offAllNamed(Routes.REGISTER);
                            },
                            child: Text("You don't have an account?".tr),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.offAllNamed(Routes.LOGIN);
                            },
                            child: Text("You remember my password!".tr),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFieldWidget(
                        labelText: "New password".tr,
                          hintText: "".tr,
                          initialValue: "",
                          onSaved: (input) => controller.currentUser.value.password = input,
                          validator: (input) => input.length < 3 ? "Should be more than 3 characters".tr : null,
                          obscureText: controller.hidePassword.value,
                          iconData: Icons.lock_outline,
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.hidePassword.value = !controller.hidePassword.value;
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                          ),
                      ),
                      BlockButtonWidget(
                        onPressed: controller.sendResetLink,
                        color: Colors.red[400],
                        text: Text(
                          "Reset".tr,
                          style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor)),
                        ),
                      ).paddingSymmetric(vertical: 35, horizontal: 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.offAllNamed(Routes.REGISTER);
                            },
                            child: Text("You don't have an account?".tr),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.offAllNamed(Routes.LOGIN);
                            },
                            child: Text("You remember my password!".tr),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ));
  }
}
