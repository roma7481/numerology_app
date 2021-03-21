import 'package:flutter/material.dart';
import 'package:numerology/app/presentation/welcome_page/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        unselectedWidgetColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}
