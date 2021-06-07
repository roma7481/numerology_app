import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numerology/app/business_logic/cubit/purchases/purchases_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/premium/premium_controller.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';
import 'package:numerology/app/presentation/common_widgets/premium_card.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/pages/graphs/bio_pi_charts.dart';
import 'package:numerology/app/presentation/pages/pay_wall/pay_wall.dart';

import 'circle_widget.dart';
import 'compat_circle_widget.dart';
import 'matrix_line_data.dart';
import 'matrix_utils.dart';

class CompatInternalPage extends StatefulWidget {
  final List<int> yourMatrix;
  final List<int> partnerMatrix;
  final List<CardData> matrixData;
  final List<CardData> lifePathData;
  final List<CardData> bioData;
  final List<double> bioCompat;
  final int yourLifePath;
  final int partnersLifePath;
  final int coupleNumSpanish;
  final List<CardData> coupleNumData;
  final Function getPage;

  const CompatInternalPage({
    Key key,
    this.yourMatrix,
    this.partnerMatrix,
    this.matrixData,
    this.lifePathData,
    this.yourLifePath,
    this.partnersLifePath,
    this.bioData,
    this.bioCompat,
    this.getPage,
    this.coupleNumSpanish,
    this.coupleNumData,
  }) : super(key: key);

  @override
  _CompatInternalPageState createState() => _CompatInternalPageState();
}

class _CompatInternalPageState extends State<CompatInternalPage> {
  var _language = Globals.instance.language;
  var _isPremium = false;
  var _selectedIndex = 0;
  var _header = Globals.instance.language.matrixCompat;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PurchasesCubit, PurchasesState>(
        listener: (context, state) {
          if (state is PurchasesSuccess) {
            setState(() {});
          }
        },
      child: _buildPageContent(),
    );
  }

  FutureBuilder<bool> _buildPageContent() {
    return FutureBuilder(
      future: PremiumController.instance.isCompat(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _isPremium = snapshot.data;
          if(!_isPremium){
            return PayWall();
          }
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  title: Text(_header),
                  brightness: Brightness.dark),
              body: _buildContent(context),
            ),
          );
        } else {
          return progressBar();
        }
      },
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
    List<Widget> previewWidgets = [_buildTopNav()];
    if (_selectedIndex == 0) {
      if (widget.coupleNumSpanish != null) {
        previewWidgets.addAll(_buildCoupleNumCompat());
      } else {
        previewWidgets.addAll(_buildMatrixCompat());
      }
    } else if (_selectedIndex == 1) {
      previewWidgets.addAll(_buildBioCompat());
    } else {
      previewWidgets.addAll(_buildLifePathCompat());
    }
    return previewWidgets;
  }

  SliverFixedExtentList _buildTopNav() {
    return SliverFixedExtentList(
        itemExtent: 80.0,
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

  Widget _buildButton(double width, int index, String iconPath) {
    return Wrap(
      children: [
        Column(
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
        )
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

  List<Widget> _buildCoupleNumCompat() {
    return [
      _buildCoupleNumberIcon(context, widget.coupleNumSpanish.toString()),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 150.0,
        ),
      ),
      _buildCoupleList(widget.coupleNumData),
    ];
  }

  Widget _buildCoupleNumberIcon(BuildContext context, String calculation) {
    return SliverToBoxAdapter(
      child: Container(
        height: 30,
        child: CustomPaint(
          painter: OpenPainter(context, calculation),
        ),
      ),
    );
  }

  Widget _buildCoupleList(List<CardData> dataList) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var data = dataList[index];
        return buildTile(data);
      },
      childCount: dataList.length,
    ));
  }

  List<Widget> _buildBioCompat() {
    return [
      _buildPiCharts(),
      _buildList(widget.bioData),
    ];
  }

  List<Widget> _buildLifePathCompat() {
    return [
      _buildNumberIcon(
          context, widget.yourLifePath.toString(), _language.yourLifePathNum),
      _buildNumberIcon(context, widget.partnersLifePath.toString(),
          _language.partnerLifePathNum),
      _buildPadding(),
      _buildList(widget.lifePathData),
    ];
  }

  List<Widget> _buildMatrixCompat() {
    return [
      _buildMatrixContent(),
      _buildList(widget.matrixData),
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
                Flexible(
                  child: Text(
                    text,
                    style: lifePathCompat,
                  ),
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
        return buildTile(data);
      },
      childCount: dataList.length,
    ));
  }

  Widget buildTile(CardData data) {
    if (_isPremium) {
      return ExpandableTile(
        data.header,
        data.description,
        iconPath: data.iconPath,
      );
    }
    return buildPremiumCard(
        context, data.header, data.description, data.iconPath);
  }

  Widget _buildPiCharts() {
    return SliverToBoxAdapter(
      child: CustomCard(
        child: buildBioPiCharts(
          context,
          widget.bioCompat,
          isHeaderVisible: false,
        ),
      ),
    );
  }

  Widget _buildPadding() {
    return SliverToBoxAdapter(
        child: SizedBox(
      height: 30.0,
    ));
  }
}
