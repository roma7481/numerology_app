import 'package:flutter/material.dart';

import 'ad_service.dart';
import 'native_admob.dart';
import 'native_admob_controller.dart';

Widget showAdInList(
  NativeAdmobController adController,
  List<dynamic> data,
  int index,
  bool isPremium,
) {
  if (!isPremium && (data.length <= 3 && index == 1)) {
    return showNativeAd(adController);
  } else if (!isPremium && (data.length > 3 && (index == 1 || index == 3))) {
    return showNativeAd(adController);
  }
  return Container();
}

Widget showNativeAd(NativeAdmobController adController,
    {bool isPremium = false}) {
  if (isPremium) {
    return Container();
  }

  return SizedBox(
      height: 400,
      child: NativeAdmob(
        // Your ad unit id
        error: Visibility(
          child: Container(),
          maintainSize: false,
          visible: false,
        ),
        adUnitID: realNativeAppId,
        numberAds: 2,
        controller: adController,
        type: NativeAdmobType.full,
      ));
}
