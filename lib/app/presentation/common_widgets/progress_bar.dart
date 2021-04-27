import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

Widget progressBar() {
  Widget progressIndicator =
      Platform.isIOS ? showCupertinoProgressBar() : CircularProgressIndicator();

  return Container(color: backgroundColor, child: progressIndicator);
}

Widget showCupertinoProgressBar() {
  return NutsActivityIndicator(
    radius: 33,
    activeColor: activeProgress,
    inactiveColor: inactiveProgress,
    tickCount: 11,
    startRatio: 0.55,
  );
}
