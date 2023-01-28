import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:turing_assessment_getx/shared/constants/ConstantSize.dart';

import '../../helper/internet_checker_helper/internet_checker_helper_logic.dart';
import 'dashboard_logic.dart';

class DashboardPage extends GetView<DashboardLogic> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<DashboardLogic>();
    Get.find<InternetCheckerHelperLogic>();
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: controller.kGooglePlex,
              onMapCreated: (GoogleMapController gmcontroller) {
                controller.mcontroller.complete(gmcontroller);
              },
              mapToolbarEnabled: true,
            ),
            ResponsiveBuilder(
              builder: (context, sizingInformation) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: TextField(
                        onChanged: (value) {
                          controller.getSearchText(text: value);
                        },
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.black,
                          fontSize: SizeConstant.fontSizes(context: Get.context!,sizingInformation: sizingInformation,type: SizeConstant.SUBTITLE),
                        ),
                        decoration: InputDecoration(
                          hintText: "E.G restaurant, fuel stations",
                          hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey,
                              fontSize: SizeConstant.fontSizes(context: Get.context!,sizingInformation: sizingInformation,type: SizeConstant.SUBTITLE),
                          ),
                          contentPadding: EdgeInsets.all(20.0),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                    
                    Obx(() => controller.predictions.isNotEmpty ? SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: controller.predictions.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Text(controller.predictions[index]["description"]);
                        },
                      ),
                    ) : SizedBox(),),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
