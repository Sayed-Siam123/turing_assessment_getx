import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class LoaderConstant{
  static loader(){
    return Get.dialog(BackdropFilter(filter: ImageFilter.blur(),blendMode: BlendMode.overlay,child: CupertinoActivityIndicator(radius: 20),),barrierDismissible: true,useSafeArea: true);
  }
}