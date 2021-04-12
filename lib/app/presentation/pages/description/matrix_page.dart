import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/data/language/matrix_tile.dart';
import 'package:numerology/app/presentation/common_widgets/castom_category_card.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';

import 'matrix_data.dart';

class MatrixPage extends StatefulWidget {
  final String header;
  final String guideText;
  final List<int> matrix;
  final List<MatrixData> data;

  const MatrixPage({
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

  @override
  void initState() {
    super.initState();
    _descriptionCard = widget.data[0].description;
    _infoCard = widget.data[0].info;
  }

  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context);
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(widget.header),
          brightness: Brightness.dark),
      body: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          _buildMatrix(context),
          _buildGuideText(),
          _buildDescription(),
          _buildInfo(),
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
      return CustomCard(
          child: ExpandablePanel(
        theme: ExpandableThemeData(iconColor: arrowColor),
        header: _buildHeader(header),
        collapsed: _buildCardContent(content: content, isFolded: true),
        expanded: _buildCardContent(
          content: content,
        ),
      ));
    } else {
      return CustomCard(
          child: CustomCategoryCard(
        header: header,
        content: content,
      ));
    }
  }

  Widget _buildHeader(String header) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 24.0,
        ),
        child: Text(
          header,
          style: descriptionHeaderStyle,
        ),
      ),
    );
  }

  Widget _buildCardContent({String content, bool isFolded = false}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(content,
          maxLines: isFolded ? 6 : 2000,
          style: descriptionContentStyle,
          overflow: isFolded ? TextOverflow.ellipsis : TextOverflow.visible),
    );
  }

  Widget _buildInfo() {
    return SliverToBoxAdapter(
        child: _buildCard(_infoCard.keys.first, _infoCard.values.first));
  }
}
