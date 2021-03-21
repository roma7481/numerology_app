import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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