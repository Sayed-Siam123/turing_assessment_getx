import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turing_assessment_getx/shared/constants/ConstantSize.dart';
import 'package:turing_assessment_getx/widgets/textwidgets.dart';

import '../../helper/internet_checker_helper/internet_checker_helper_logic.dart';
import 'splash_logic.dart';

class SplashPage extends GetView<SplashLogic> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<SplashLogic>();
    Get.find<InternetCheckerHelperLogic>();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: TextBoxConstant.textWidget(
              text: "TURING ASSESSMENT",
              textAlign: TextAlign.center,
              size: SizeConstant.LARGETEXT
          ),
        ),
      ),
    );
  }
}
