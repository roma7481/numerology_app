import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/presentation/pages/home/custom_raised_button.dart';

class CompatInternalPage extends StatefulWidget {
  @override
  _CompatInternalPageState createState() => _CompatInternalPageState();
}

class _CompatInternalPageState extends State<CompatInternalPage> {
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
            CustomButton(
              child: Container(
                child: SvgPicture.asset(work, height: width * 0.2),
              ),
              onPressed: () {},
            ),
            CustomButton(
              child: Container(
                child: SvgPicture.asset(work, height: width * 0.2),
              ),
              onPressed: () {},
            ),
            CustomButton(
              child: Container(
                child: SvgPicture.asset(work, height: width * 0.2),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
