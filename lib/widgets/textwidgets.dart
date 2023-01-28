import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../shared/constants/ConstantSize.dart';

abstract class TextBoxConstant{
  static textWidget({text,size = SizeConstant.MEDIUMTEXT,color,weight = FontWeight.w500,textAlign,textWrap=true}){
    final textScale = ScreenUtil().textScaleFactor;
    return Text(
      text.toString(),
      textAlign: textAlign,
      style: Theme.of(Get.context!).textTheme.bodyText2!.copyWith(
        color: color ?? Theme.of(Get.context!).textTheme.bodyText2!.color,
        //fontSize: const AdaptiveTextSize().getadaptiveTextSize(Get.context!, size, Get.height),
        fontSize: double.parse(size.toString())*textScale,
        fontWeight: weight,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      softWrap: textWrap,
    );
  }
}
