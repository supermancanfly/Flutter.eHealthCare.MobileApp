/*
 * Copyright (c) 2020 .
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../services/auth_service.dart';
import '../../services/settings_service.dart';
import '../custom_pages/views/custom_page_drawer_link_widget.dart';
import '../root/controllers/root_controller.dart' show RootController;
import '../../modules/auth/controllers/google_controller.dart';
import 'drawer_link_widget.dart';

class MainDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.yellow,
      width: 250,
      child: ListView(
        children: [
          Obx(() {
            if (!Get.find<AuthService>().isAuth) {
              return GestureDetector(
                onTap: () {
                  Get.back();
                  Get.toNamed(Routes.LOGIN);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              );
            } else {
              return GestureDetector(
                onTap: () async {
                  // await Get.find<RootController>().changePage(4);
                },
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                  ),
                  accountName: Text(
                    Get.find<AuthService>().user.value.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  accountEmail: Text(
                    Get.find<AuthService>().user.value.email,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  currentAccountPicture: Stack(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                          child: CachedNetworkImage(
                            height: 80,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: Get.find<AuthService>().user.value.avatar.thumb,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 80,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error_outline),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Get.find<AuthService>().user.value.verifiedPhone ?? false ? Icon(Icons.check_circle, color: Colors.yellow, size: 24) : SizedBox(),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
          DrawerLinkWidget(
            icon: Icons.home_outlined,
            text: "Home",
            onTap: (e) async {
              Get.back();
              await Get.find<RootController>().changePage(0);
            },
          ),
          Divider(color: Colors.black),
          DrawerLinkWidget(
            icon: Icons.folder_special_outlined,
            text: "Specialities",
            onTap: (e) {
              Get.offAndToNamed(Routes.SPECIALITIES);
            },
          ),
          Divider(color: Colors.black),
          DrawerLinkWidget(
            icon: Icons.notifications_none_outlined,
            text: "Notifications",
            onTap: (e) {
              Get.offAndToNamed(Routes.NOTIFICATIONS);
            },
          ),
          Divider(color: Colors.black),
          DrawerLinkWidget(
            icon: Icons.assignment_outlined,
            text: "My Appointments",
            onTap: (e) async {
              Get.back();
              await Get.find<RootController>().changePage(1);
            },
          ),
          Divider(color: Colors.black),
          DrawerLinkWidget(
            icon: Icons.group_outlined,
            text: "Patients",
            onTap: (e) async {
              Get.back();
              Get.find<RootController>().changePage(3);
            },
          ),

          // DrawerLinkWidget(
          //   icon: Icons.favorite_outline,
          //   text: "Favorites",
          //   onTap: (e) async {
          //     await Get.offAndToNamed(Routes.FAVORITES);
          //   },
          // ),
          // DrawerLinkWidget(
          //   icon: Icons.chat_outlined,
          //   text: "Messages",
          //   onTap: (e) async {
          //     Get.back();
          //     await Get.find<RootController>().changePage(2);
          //   },
          // ),
          // DrawerLinkWidget(
          //   icon: Icons.account_balance_wallet_outlined,
          //   text: "Wallets",
          //   onTap: (e) async {
          //     await Get.offAndToNamed(Routes.WALLETS);
          //   },
          // ),
          Divider(color: Colors.black),
          DrawerLinkWidget(
            icon: Icons.settings_outlined,
            text: "Settings",
            onTap: (e) async {
              await Get.offAndToNamed(Routes.SETTINGS);
            },
          ),
          Divider(color: Colors.black),
          DrawerLinkWidget(
            icon: Icons.help_outline,
            text: "Help & FAQ",
            onTap: (e) async {
              await Get.offAndToNamed(Routes.HELP);
            },
          ),
          Divider(color: Colors.black),
          Obx(() {
            if (Get.find<AuthService>().isAuth) {
              return DrawerLinkWidget(
                icon: Icons.logout,
                text: "Logout",
                onTap: (e) async {
                  await Get.find<AuthService>().removeCurrentUser();
                  Get.back();
                  await Get.find<RootController>().changePage(1);
                },
              );
            } else {
              return SizedBox(height: 0);
            }
          }),
        ],
      ),
    );
  }
}
