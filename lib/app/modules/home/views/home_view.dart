import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../providers/laravel_provider.dart';
import '../../global_widgets/address_widget.dart';
import '../controllers/home_controller.dart';
import '../../global_widgets/home_search_bar_widget.dart';
import '../../../routes/app_routes.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 70.0),
            child: Image.asset(
              'assets/icon/icon_top.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.sort, color: Get.theme.hintColor),
          onPressed: () => {Scaffold.of(context).openDrawer()},
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<LaravelApiClient>().forceRefresh();
          controller.refreshHome(showMessage: true);
          Get.find<LaravelApiClient>().unForceRefresh();
        },
        child: ListView(
          primary: true,
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 30,
            ),
            HomeSearchBarWidget(),
            SizedBox(
              height: 10,
            ),
            AddressWidget(),
            Container(
              margin: EdgeInsets.fromLTRB(30, 60, 0, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.SPECIALITIES);
                        },
                        child: Container(
                          width: screenWidth * 0.41, // Adjusted width
                          margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.yellow,
                            boxShadow: kElevationToShadow[2],
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Image.asset("assets/icon/book.png"),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Book Consultation".tr,
                                style: Get.textTheme.caption.merge(
                                  TextStyle(
                                    color: Colors.black,
                                    height: 0,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.41, // Adjusted width
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.purple,
                          boxShadow: kElevationToShadow[4],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Image.asset("assets/icon/homeservice1.png"),
                                Image.asset("assets/icon/homeservice2.png"),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Home Services".tr,
                              style: Get.textTheme.caption.merge(
                                TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 0,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.41, // Adjusted width
                        margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.purple,
                          boxShadow: kElevationToShadow[2],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Image.asset("assets/icon/mental.png"),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Mental Health".tr,
                              style: Get.textTheme.caption.merge(
                                TextStyle(
                                  color: Colors.white,
                                  height: 0,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth * 0.41, // Adjusted width
                        margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.yellow,
                          boxShadow: kElevationToShadow[2],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Image.asset("assets/icon/second.png"),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Second Option".tr,
                              style: Get.textTheme.caption.merge(
                                TextStyle(
                                  color: Colors.black,
                                  height: 0,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
