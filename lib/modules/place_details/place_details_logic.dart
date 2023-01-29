import 'package:get/get.dart';
import 'package:turing_assessment_getx/provider/api_provider.dart';

import '../../helper/loader.dart';
import 'package:dio/dio.dart' as dio;

class PlaceDetailsLogic extends GetxController {

  var data = Get.arguments;

  var name = "".obs;
  var placeID = "".obs;
  var address = "".obs;

  var lat = 0.0.obs;
  var lng = 0.0.obs;

  var photosList = [].obs;

  var currentIndex = 0.obs;

  ApiProvider? apiProvider = ApiProvider();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(data);
    name.value = data["name"];
    placeID.value = data["place_id"];
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getPlaceDetails(placeid: placeID.value);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  getPlaceDetails({placeid}) async{
    LoaderConstant.loader();
    dio.Response? data = await apiProvider!.getPlaceDetails(placeID: placeid.toString());

    address.value = data!.data["result"]["formatted_address"].toString();
    lat.value = data.data["result"]["geometry"]["location"]["lat"];
    lng.value = data.data["result"]["geometry"]["location"]["lng"];
    placeID.value = data.data["result"]["place_id"].toString();

    getPhotos(photos: data.data["result"]["photos"] as List);

    await Future.delayed(Duration(seconds: 2));
    Get.back();
  }

  getPhotos({photos}) {
    for(int i = 0; i<photos.length; i++){
      photosList.value.add(photos[i]["photo_reference"]);
    }
  }

}
