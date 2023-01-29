import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:turing_assessment_getx/widgets/textwidgets.dart';

import '../../helper/internet_checker_helper/internet_checker_helper_logic.dart';
import '../../shared/constants/ConstantSize.dart';
import '../../shared/constants/colors.dart';
import 'place_details_logic.dart';

class PlaceDetailsPage extends GetView<PlaceDetailsLogic> {
  const PlaceDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PlaceDetailsLogic>();
    Get.find<InternetCheckerHelperLogic>();
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.name.value.toString()),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlutterCarousel(
                options: CarouselOptions(
                    viewportFraction: 1,
                    height: 200.0,
                    showIndicator: false,
                    floatingIndicator: false,
                    onPageChanged: (index, reason) {
                      controller.currentIndex.value = index;
                    }
                ),
                items: controller.photosList.value.map((photoItem) {
                  return Builder(
                    builder: (BuildContext context) {
                      // return Container(
                      //   decoration: BoxDecoration(
                      //     color: ColorConstants.WHITE,
                      //   ),
                      //   child: Text(photoItem.toString()),
                      // );
                      print(photoItem);
                      return Image.network(
                        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&maxheight=200&photoreference=$photoItem&key=AIzaSyCBkUYS9WF-PtOKtHoWz5yqkEhqt4OMiRg",
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              TextBoxConstant.textWidget(text: controller.name.value.toString()),
              TextBoxConstant.textWidget(text: controller.address.value.toString()),
            ],
          ),
        );
      }),
    );
  }
}
