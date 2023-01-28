import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/internet_checker_helper/internet_checker_helper_logic.dart';
import 'place_details_logic.dart';

class PlaceDetailsPage extends GetView<PlaceDetailsLogic> {
  const PlaceDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PlaceDetailsLogic>();
    Get.find<InternetCheckerHelperLogic>();
    return Container();
  }
}
