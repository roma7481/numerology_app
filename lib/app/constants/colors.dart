import 'dart:ui';

import 'package:flutter/material.dart';

var appBarColor = 0xFF00203b;

Map<int, Color> appBarColorMap = {
  50: Color.fromRGBO(4, 131, 184, .1),
  100: Color.fromRGBO(4, 131, 184, .2),
  200: Color.fromRGBO(4, 131, 184, .3),
  300: Color.fromRGBO(4, 131, 184, .4),
  400: Color.fromRGBO(4, 131, 184, .5),
  500: Color.fromRGBO(4, 131, 184, .6),
  600: Color.fromRGBO(4, 131, 184, .7),
  700: Color.fromRGBO(4, 131, 184, .8),
  800: Color.fromRGBO(4, 131, 184, .9),
  900: Color.fromRGBO(4, 131, 184, 1),
};

const Color backgroundColor = Color.fromRGBO(0, 32, 59, 1);
const Color pickerHeaderColor = Color.fromRGBO(128, 202, 255, 1);
const Color cursorColor = Colors.white;
const Color dateOfBirthButtonColor = Color.fromRGBO(75, 161, 222, 1);
const Color weddingDateButtonColor = Color.fromRGBO(75, 161, 222, 1);
const Color partnerDobButtonColor = Color.fromRGBO(75, 161, 222, 1);
const Color yellowButtonColor = Color.fromRGBO(255, 228, 92, 1);
const Color greyButtonColor = Color.fromRGBO(199, 199, 199, 1);
const Color hintColor = Color.fromRGBO(140, 140, 140, 0.7);
const Color inputTextUnfocused = Color.fromRGBO(140, 140, 140, 0.7);
const Color inputTextFocused = Color.fromRGBO(75, 161, 222, 0.7);
const Color inputTextColor = Color.fromRGBO(128, 202, 255, 0.7);
const Color welcomeScreenTextColor = Colors.white;

/// BOTTOM NAVIGATION ///
const Color bottomNavBarColor = Color.fromRGBO(0, 21, 38, 1);
const Color itemTapPressedColor = Color.fromRGBO(128, 202, 255, 1);
const Color itemTapDefaultColor = Color.fromRGBO(65, 112, 150, 1);

/// HOME PAGE ///
const Color categoryTileText = Colors.white;
const Color tileColor = Color.fromRGBO(0, 63, 115, 1);
const Color tileTransparentColor = Color.fromRGBO(0, 63, 115, 0);

/// PROGRESS BAR ///
const Color activeProgress = Color.fromRGBO(128, 202, 255, 1);
const Color inactiveProgress = Color.fromRGBO(0, 63, 115, 1);

/// DESCRIPTION PAGE ///
const Color circleColor = Color.fromRGBO(252, 186, 3, 1);
const Color arrowColor = Color.fromRGBO(252, 186, 3, 1);

/// MATRIX TILE ///
const Color unselectedTileColor = Color.fromRGBO(0, 63, 115, 1);
const Color selectedTileColor = Color.fromRGBO(40, 77, 181, 1);

/// BIO ///

const Color bioCircleBg = Color.fromRGBO(74, 87, 145, 1);

const Color bioPhysicalCircleStart = Color.fromRGBO(66, 142, 235, 1);
const Color bioPhysicalCircleEnd = Color.fromRGBO(0, 171, 106, 1);

const Color bioEmotionCircleStart = Color.fromRGBO(214, 74, 81, 1);
const Color bioEmotionCircleEnd = Color.fromRGBO(243, 190, 0, 1);

const Color intellectEmotionCircleStart = Color.fromRGBO(148, 99, 235, 1);
const Color intellectEmotionCircleEnd = Color.fromRGBO(66, 142, 235, 1);

const Color aestheticEmotionCircleStart = Color.fromRGBO(251, 133, 255, 1);
const Color aestheticEmotionCircleEnd = Color.fromRGBO(255, 92, 138, 1);

const LinearGradient physicalGradient = LinearGradient(colors: physicalColors);
const LinearGradient emotionalGradient = LinearGradient(colors: emotionColors);
const LinearGradient intellectGradient = LinearGradient(colors: intelColors);

const LinearGradient spiritGradient = LinearGradient(colors: spiritColors);
const LinearGradient awareGradient = LinearGradient(colors: awareColors);
const LinearGradient intuitGradient = LinearGradient(colors: intuitColors);
const LinearGradient aestheticGradient =
    LinearGradient(colors: aestheticColors);

const List<Color> physicalColors = [
  bioPhysicalCircleStart,
  bioPhysicalCircleEnd,
];

const List<Color> emotionColors = [
  bioEmotionCircleStart,
  bioEmotionCircleEnd,
];

const List<Color> intelColors = [
  intellectEmotionCircleStart,
  intellectEmotionCircleEnd,
];

const List<Color> spiritColors = physicalColors;
const List<Color> intuitColors = intelColors;
const List<Color> awareColors = emotionColors;
const List<Color> aestheticColors = [
  aestheticEmotionCircleStart,
  aestheticEmotionCircleEnd,
];

/// GRAPH ///

const Color graphDates = Colors.white;
