import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turing_assessment_getx/helper/snackbarHelper.dart';
import 'package:turing_assessment_getx/provider/api_provider.dart';
import 'package:uuid/uuid.dart';

class DashboardLogic extends GetxController {

  var predictions = [].obs;

  final Completer<GoogleMapController> mcontroller =
  Completer<GoogleMapController>();

  ApiProvider? apiProvider = ApiProvider();

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _gotoSelectedPlaceAndMark({positions}) async {
    final GoogleMapController controller = await mcontroller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        //target: LatLng(37.43296265331129, -122.08832357078792),
        target: positions,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414))
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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


  getSearchText({text}) async{
    predictions.clear();

    var sessionToken = Uuid().v4();

    dio.Response? data = await apiProvider!.getPlaceSearch(text: text.toString(),sessionToken: sessionToken.toString());

    if(data!.statusCode == 200 && data.data["status"] != "INVALID_REQUEST"){

      if(data.data["predictions"].length != 0){
        print(data.data["predictions"]);
        predictions.addAll(data.data["predictions"]);
      }
      else{
        predictions.clear();
      }
    }
  }
}
