import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:turing_assessment_getx/helper/snackbarHelper.dart';
import 'package:turing_assessment_getx/provider/api_provider.dart';
import 'package:turing_assessment_getx/routes/app_pages.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';

import '../../helper/loader.dart';

class DashboardLogic extends GetxController {

  var predictions = [].obs;
  var markers = <Marker>[].obs;

  var name = "".obs;
  var address = "".obs;

  var lat = 0.0.obs;
  var lng = 0.0.obs;

  var placeID = "".obs;

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
    predictions.clear();
    final GoogleMapController controller = await mcontroller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        //target: LatLng(37.43296265331129, -122.08832357078792),
        target: positions,
        tilt: 59.440717697143555,
        zoom: 19.151926040649414))
    );
  }

  Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }


  addMarker({LatLng? position,markerID,markerIcon,name}) async{
    final Uint8List markIcons = await getImages("assets/images/map_pin.png", 100);
    markers.add(
        Marker(
          markerId: MarkerId(markerID.toString()),
          icon: BitmapDescriptor.fromBytes(markIcons),
          position: position!,
          infoWindow: InfoWindow(
            title: name,
            onTap: () {
              Get.toNamed(Routes.PLACEDETAILS,arguments: {
                "place_id" : placeID.toString(),
                "name" : name.toString(),
              });
            },
          ),
        )
    );
  }

  @override
  onInit() async{
    // TODO: implement onInit
    super.onInit();
    await getInitialLatLngInfo(lat: 37.43296265331129,lng: -122.08832357078792);
    await addMarker(position: LatLng(37.43296265331129, -122.08832357078792),markerID: "initial",markerIcon: "",name: name.value);
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
        predictions.addAll(data.data["predictions"]);
      }
      else{
        predictions.clear();
      }
    }
  }

  getPlaceDetails({placeid}) async{
    LoaderConstant.loader();
    dio.Response? data = await apiProvider!.getPlaceDetails(placeID: placeid.toString());

    name.value = data!.data["result"]["formatted_address"].toString();
    lat.value = data.data["result"]["geometry"]["location"]["lat"];
    lng.value = data.data["result"]["geometry"]["location"]["lng"];
    placeID.value = data.data["result"]["place_id"].toString();

    await Future.delayed(Duration(seconds: 2));
    _gotoSelectedPlaceAndMark(positions: LatLng(lat.value, lng.value));
    await addMarker(position: LatLng(lat.value, lng.value),markerID: "searched",markerIcon: "",name: name.value);
    Get.back();
  }

  getInitialLatLngInfo({lat,lng}) async{
    dio.Response? data = await apiProvider!.getPlaceDetailsWithUsingCoOrdinates(lat: lat,lng: lng);
    name.value = data!.data["plus_code"]["compound_code"];
    placeID.value = data.data["results"][0]["place_id"].toString();
  }

}
