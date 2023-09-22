import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../providers/laravel_provider.dart';
import '../../global_widgets/address_widget.dart';
import '../../global_widgets/home_search_bar_widget.dart';
import '../controllers/speciality_controller.dart';
import '../widgets/doctors_list_widget.dart';
@override
class SpecialityView extends GetView<SpecialityController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          if (!Get.find<LaravelApiClient>()
              .isLoading(tasks: ['getAllDoctorsWithPagination', 'getFeaturedDoctors', 'getPopularDoctors', 'getMostRatedDoctors', 'getAvailableDoctors'])) {
            Get.find<LaravelApiClient>().forceRefresh();
            controller.refreshDoctors(showMessage: true);
            Get.find<LaravelApiClient>().unForceRefresh();
          }
        },
        child: CustomScrollView(
          controller: controller.scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: false,
          slivers: <Widget>[
            SliverToBoxAdapter(

              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:50, left:30, right:30), // Add the desired padding
                    child: HomeSearchBarWidget(),
                  ),
                  Container(
                    height: 60,
                    child: ListView(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: List.generate(SpecialityFilter.values.length, (index) {
                          var _filter = SpecialityFilter.values.elementAt(index);
                          return Obx(() {
                            return Padding(
                              padding: const EdgeInsetsDirectional.only(start: 20),
                              child: RawChip(
                                elevation: 0,
                                label: Text(_filter.toString().tr),
                                labelStyle: controller.isSelected(_filter) ? Get.textTheme.bodyText2.merge(TextStyle(color: Get.theme.primaryColor)) : Get.textTheme.bodyText2,
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                backgroundColor: Theme.of(context).focusColor.withOpacity(0.1),
                                selectedColor: Colors.purple[300],
                                selected: controller.isSelected(_filter),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                showCheckmark: true,
                                checkmarkColor: Colors.yellow,
                                onSelected: (bool value) {
                                  controller.toggleSelected(_filter);
                                  controller.loadDoctorsOfSpeciality(controller.speciality.value.id, filter: controller.selected.value);
                                },
                              ),
                            );
                          });
                        })),
                  ),
                  DoctorsListWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}