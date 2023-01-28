import 'package:get/get.dart';

import 'place_details_logic.dart';

class PlaceDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlaceDetailsLogic());
  }
}
