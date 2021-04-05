import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/icon_path.dart';

class CompatInternalPage extends StatefulWidget {
  @override
  _CompatInternalPageState createState() => _CompatInternalPageState();
}

class _CompatInternalPageState extends State<CompatInternalPage> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('header'),
          backgroundColor: backgroundColor,
        ),
        body: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: backgroundColor,
      height: double.infinity,
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildButton(width, 0),
            _buildButton(width, 1),
            _buildButton(width, 2),
          ],
        ),
      ),
    );
  }

  Column _buildButton(double width, int index) {
    return Column(
      children: [
        customButton(
          child: Container(
            child: SvgPicture.asset(work, height: width * 0.2),
          ),
          onPressed: () {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        Opacity(
            opacity: index == _selectedIndex ? 1 : 0,
            child: buildLine(width * 0.2)),
      ],
    );
  }

  Widget buildLine(double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: 3.0,
        width: width,
        color: Colors.white,
      ),
    );
  }

  Widget customButton({Widget child, VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          child: child,
        ),
      ),
    );
  }
}
