import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/constants/text_styles.dart';

import 'matrix_utils.dart';

class CompatInternalPage extends StatefulWidget {
  final List<int> yourMatrix;
  final List<int> partnerMatrix;

  const CompatInternalPage({Key key, this.yourMatrix, this.partnerMatrix})
      : super(key: key);

  @override
  _CompatInternalPageState createState() => _CompatInternalPageState();
}

class _CompatInternalPageState extends State<CompatInternalPage> {
  var _language = Globals.instance.language;
  var _selectedIndex = 0;
  var _header = Globals.instance.language.matrixCompat;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_header),
          backgroundColor: backgroundColor,
        ),
        body: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: double.infinity,
      child: CustomScrollView(
        slivers: [
          _buildTopNav(),
          _buildPageDescription(),
        ],
      ),
    );
  }

  SliverFixedExtentList _buildTopNav() {
    return SliverFixedExtentList(
        itemExtent: 100.0,
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return new Container(
            alignment: Alignment.center,
            child: _buildButtons(),
          );
        }, childCount: 1));
  }

  Align _buildButtons() {
    var width = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButton(width, 0, matrixComp),
          _buildButton(width, 1, bioComp),
          _buildButton(width, 2, lifePathComp),
        ],
      ),
    );
  }

  Column _buildButton(double width, int index, String iconPath) {
    return Column(
      children: [
        customButton(
          child: Container(
            child: SvgPicture.asset(iconPath, height: width * 0.15),
          ),
          onPressed: () {
            setState(() {
              _header = index == 0
                  ? _header = _language.matrixCompat
                  : index == 1
                      ? _language.bioCompat
                      : _language.lifePathCompat;

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

  Widget _buildPageDescription() {
    if (_selectedIndex == 0) {
      return _buildMatrixContent();
    } else if (_selectedIndex == 1) {
      return SliverToBoxAdapter(child: Container());
    }
    return SliverToBoxAdapter(child: Container());
  }

  Widget _buildMatrixContent() {
    return SliverToBoxAdapter(
      child: Column(children: [
        Text(
          _language.yourMatrix,
          style: matrixNotice,
        ),
        buildMatrix(context, widget.yourMatrix),
        Text(
          _language.partnerMatrix,
          style: matrixNotice,
        ),
        buildMatrix(context, widget.partnerMatrix),
      ]),
    );
  }
}
