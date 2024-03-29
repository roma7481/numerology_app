import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';

import 'colors.dart';

///  WELCOME_PAGE ///

var headerTextStyle = GoogleFonts.philosopher(
  textStyle: TextStyle(
    fontSize: 19.0,
    color: welcomeScreenTextColor,
    fontWeight: FontWeight.bold,
  ),
);

var contentTextStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 18.0,
  color: Colors.white,
));

var radioButtonTextStyle = GoogleFonts.philosopher(
    textStyle: TextStyle(
  fontSize: 17.0,
  fontWeight: FontWeight.bold,
  color: pickerHeaderColor,
));

var languageTextStyle = GoogleFonts.philosopher(
    textStyle: TextStyle(
  fontSize: 17.0,
  color: Colors.white,
));

var dateOfBirthButtonTextStyle = GoogleFonts.philosopher(
    textStyle: TextStyle(
  fontSize: 17.0,
  color: Colors.white,
));

var continueButtonTextStyle = GoogleFonts.philosopher(
    textStyle: TextStyle(
  fontSize: 17.0,
  color: Colors.black,
));

var radioButtonColor = MaterialStateColor.resolveWith((states) => Colors.white);

/// TIME PICKER ///

TextStyle datePickerTextStyle() {
  double textSize = Globals.instance.getTextSize();
  return GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
    fontSize: textSize,
    color: Colors.black,
  ));
}

/// NAME SETTINGS PAGE ///

var noticeTextStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 16.0,
  color: pickerHeaderColor,
));

/// HOME PAGE ///

var categoryTileHeader = GoogleFonts.philosopher(
  textStyle: TextStyle(
    fontSize: 17.0,
    color: categoryTileText,
  ),
);

TextStyle personalDayText() {
  double textSize = Globals.instance.getTextSize();
  return GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
    fontSize: textSize,
    color: categoryTileText,
  ));
}

/// DESCRIPTION PAGE ///

var calcNumber = GoogleFonts.arefRuqaa(
  textStyle: TextStyle(
    fontSize: 50.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
);

TextStyle descriptionContentStyle() {
  double textSize = Globals.instance.getTextSize();
  return GoogleFonts.sourceSansPro(
      textStyle: TextStyle(
    fontSize: textSize,
    color: Colors.white,
  ));
}

var descriptionHeaderStyle = GoogleFonts.philosopher(
    textStyle: TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 19.0,
  color: Colors.white,
));

var readMoreStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 17.0,
  color: itemTapPressedColor,
));

/// MATRIX ///
var matrixTileStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 18.0,
  color: Colors.white,
));

var matrixNotice = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 16.0,
  color: pickerHeaderColor,
));

/// COMPAT PAGE ///

var calcNumberCompat = GoogleFonts.arefRuqaa(
  textStyle: TextStyle(
    fontSize: 30.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
);

var lifePathCompat = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 16.0,
  color: pickerHeaderColor,
));

/// BIO ///

var bioPercentage = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 16.0,
  color: Colors.white,
));

var bioNamePhis = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 16.0,
  color: bioPhysicalCircleStart,
));

var bioNameEmotion = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 16.0,
  color: bioEmotionCircleEnd,
));

var bioNameIntel = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 16.0,
  color: intellectEmotionCircleStart,
));

var bioNameSpirit = bioNamePhis;
var bioNameIntuit = bioNameIntel;
var bioNameAware = bioNameEmotion;
var bioNameAesthetic = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 16.0,
  color: aestheticEmotionCircleStart,
));

/// FORECAST ///

var forecastCardHeader = GoogleFonts.sourceSansPro(
  textStyle: TextStyle(
    fontSize: 19.0,
    color: categoryTileText,
  ),
);

var buttonTextStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 15.0,
  color: Colors.white,
));

/// PROFILES ///

var profilesWhiteText = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 15.0,
  color: Colors.white,
));

var profilesBlueText = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 15.0,
  color: itemTapPressedColor,
));

/// SETTINGS ///
TextStyle notificationPickerTextStyle =
    TextStyle(fontSize: 60.0, color: Colors.black);

TextStyle dialogHeaderTextStyle =
    TextStyle(fontSize: 19.0, color: Colors.blueAccent.shade700);

TextStyle dialogContentTextStyle =
    TextStyle(fontSize: 17.0, color: Colors.blueAccent.shade700);

TextStyle urlLinkStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 18.0,
  color: cardUrlLinkColor,
  decoration: TextDecoration.underline,
));

var priceStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 21.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
));

var oneTimePaymentStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 17.0,
  color: Colors.white,
));

var settingsTextStyle = GoogleFonts.sourceSansPro(
  textStyle: TextStyle(
    fontSize: 17.0,
    color: welcomeScreenTextColor,
  ),
);

var moreAppsTextStyle = GoogleFonts.sourceSansPro(
  textStyle: TextStyle(
    fontSize: 14.0,
    color: welcomeScreenTextColor,
  ),
);

var discountTextStyle = GoogleFonts.sourceSansPro(
    textStyle: TextStyle(
  fontSize: 15.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
));
