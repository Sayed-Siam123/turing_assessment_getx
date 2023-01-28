import 'package:get/get.dart';
import 'package:turing_assessment_getx/routes/app_pages.dart';

class SplashLogic extends GetxController {

  @override
  onInit() async{
    // TODO: implement onInit
    super.onInit();
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed(Routes.DASHBOARD);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
