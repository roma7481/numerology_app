import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context);
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tutorial - googleflutter.com'),
        backgroundColor: Colors.white,
      ),
      body: ListView(children: <Widget>[
        Text(
          'Canvas',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, height: 2),
        ),
        Container(
          color: Colors.white,
          width: 400,
          height: 400,
        ),
      ]),
    );
  }
}
