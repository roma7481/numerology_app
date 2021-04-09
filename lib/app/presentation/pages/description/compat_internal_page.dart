import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';
import 'package:numerology/app/presentation/pages/graphs/bio_pi_charts.dart';

import 'compat_circle_widget.dart';
import 'matrix_line_data.dart';
import 'matrix_utils.dart';

class CompatInternalPage extends StatefulWidget {
  final List<int> yourMatrix;
  final List<int> partnerMatrix;
  final List<CardData> matrixDescription;
  final List<CardData> lifePathDescription;
  final List<CardData> bioDescription;
  final List<double> bioCompat;
  final int yourLifePath;
  final int partnersLifePath;

  const CompatInternalPage({
    Key key,
    this.yourMatrix,
    this.partnerMatrix,
    this.matrixDescription,
    this.lifePathDescription,
    this.yourLifePath,
    this.partnersLifePath,
    this.bioDescription,
    this.bioCompat,
  }) : super(key: key);

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
        slivers: _buildPageDescription(),
      ),
    );
  }

  List<Widget> _buildPageDescription() {
    if (_selectedIndex == 0) {
      return _buildMatrixCompat();
    } else if (_selectedIndex == 1) {
      return _buildBioCompat();
    }
    return _buildLifePathCompat();
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
            child: SvgPicture.asset(iconPath, height: width * 0.10),
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

  List<Widget> _buildBioCompat() {
    return [
      _buildTopNav(),
      _buildPiCharts(),
      _buildList(widget.bioDescription),
    ];
  }

  List<Widget> _buildLifePathCompat() {
    return [
      _buildTopNav(),
      _buildNumberIcon(
          context, widget.yourLifePath.toString(), _language.yourLifePathNum),
      _buildNumberIcon(context, widget.partnersLifePath.toString(),
          _language.partnerLifePathNum),
      _buildList(widget.lifePathDescription),
    ];
  }

  List<Widget> _buildMatrixCompat() {
    return [
      _buildTopNav(),
      _buildMatrixContent(),
      _buildList(widget.matrixDescription),
    ];
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

  Widget _buildNumberIcon(
      BuildContext context, String calculation, String text) {
    var width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Container(
            width: 200,
            height: 80,
            child: CustomPaint(
              painter: CompatCircle(context, calculation),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0, left: width * 0.35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: lifePathCompat,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<CardData> dataList) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var data = dataList[index];
        return buildExpandCard(data.header, data.description, data.iconPath);
      },
      childCount: dataList.length,
    ));
  }

  Widget _buildPiCharts() {
    return SliverToBoxAdapter(
      child: buildBioPiCharts(
        context,
        widget.bioCompat,
        isHeaderVisible: false,
      ),
    );
  }
}
