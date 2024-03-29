import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:numerology/app/business_logic/services/ads/show_banner.dart';
import 'package:numerology/app/business_logic/services/ads/show_native_ad.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/data/language/matrix_tile.dart';
import 'package:numerology/app/presentation/common_widgets/castom_category_card.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';
import 'package:numerology/app/presentation/common_widgets/list_space_tile.dart';

import 'matrix_data.dart';

class MatrixPage extends StatefulWidget {
  final String header;
  final String guideText;
  final List<int> matrix;
  final List<MatrixData> data;
  final bool isPremium;

  const MatrixPage(
    this.isPremium, {
    Key key,
    this.matrix,
    this.header,
    this.guideText,
    this.data,
  }) : super(key: key);

  @override
  _MatrixPageState createState() => _MatrixPageState();
}

class _MatrixPageState extends State<MatrixPage> {
  List<int> get matrix => widget.matrix;
  var _indexSelected = 0;
  var _descriptionCard = {};
  var _infoCard = {};

  BannerAd _banner;
  AdWidget _adWidget;

  @override
  void initState() {
    super.initState();
    _descriptionCard = widget.data[0].description;
    _infoCard = widget.data[0].info;
  }

  @override
  Widget build(BuildContext context) {
    _banner = getBanner();
    _adWidget = _banner == null ? null : AdWidget(ad: _banner);

    return _buildPageContent(context);
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(widget.header),
          brightness: Brightness.dark),
      body: _buildContext(context, widget.isPremium),
      bottomNavigationBar: showBanner(_adWidget, _banner, widget.isPremium),
    );
  }

  Widget _buildContext(BuildContext context, bool isPremium) {
    var listHeight = calcListHeight(context, _banner, isPremium);

    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: Wrap(
        children: [
          Column(
            children: [
              SizedBox(
                height: listHeight,
                child: CustomScrollView(
                  slivers: [
                    _buildMatrix(context),
                    _buildGuideText(),
                    _buildDescription(),
                    _buildInfo(isPremium),
                    buildSpaceBox(context),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMatrix(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMatrixTile(context, matrix[0], 0),
                _buildMatrixTile(context, matrix[3], 3),
                _buildMatrixTile(context, matrix[6], 6),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMatrixTile(context, matrix[1], 1),
                _buildMatrixTile(context, matrix[4], 4),
                _buildMatrixTile(context, matrix[7], 7),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMatrixTile(context, matrix[2], 2),
                _buildMatrixTile(context, matrix[5], 5),
                _buildMatrixTile(context, matrix[8], 8),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMatrixTile(BuildContext context, int cellDigits, int index) {
    var height = MediaQuery.of(context).size.height;
    var sideLength = height * 0.1;
    return buildMatrixTileButton(cellDigits.toString().replaceAll('0', '-'),
        () {
      setState(() {
        _indexSelected = index;
        _descriptionCard = widget.data[index].description;
        _infoCard = widget.data[index].info;
      });
    }, sideLength, isSelected: index == _indexSelected);
  }

  Widget _buildGuideText() {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
          child: Text(
            widget.guideText,
            style: matrixNotice,
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return SliverToBoxAdapter(
        child: _buildCard(
            _descriptionCard.keys.first, _descriptionCard.values.first));
  }

  Widget _buildCard(String header, String content) {
    if (content.length > 1000) {
      return ExpandableTile(header, content);
    } else {
      return CustomCard(
          child: CustomCategoryCard(
        header: header,
        content: content,
      ));
    }
  }

  Widget _buildInfo(bool isPremium) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        showNativeAd(context, isPremium: isPremium),
        _buildCard(_infoCard.keys.first, _infoCard.values.first),
      ],
    ));
  }
}
