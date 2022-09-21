import 'package:flutter/material.dart';
import 'NativeAdItem.dart';

Widget showAdInList(
  List<dynamic> data,
  int index,
  bool isPremium,
) {
  if(isPremium){
    return Container();
  }
  if (data.length <= 3 && index == 1) {
    return const NativeAdItem();
  } else if(data.length > 3 && (index == 1 || index == 3 || index == 5 )){
    return const NativeAdItem();
  }
  return Container();
}

Widget showNativeAd(BuildContext context,
    {bool isPremium = false}) {
  if (isPremium) {
    return Container();
  }
  return const NativeAdItem();
}