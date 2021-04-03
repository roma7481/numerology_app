import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/data/language/matrix_tile.dart';

class MatrixPage extends StatefulWidget {
  final String header;
  final String guideText;
  final List<int> matrix;

  const MatrixPage({
    Key key,
    this.matrix,
    this.header,
    this.guideText,
  }) : super(key: key);

  @override
  _MatrixPageState createState() => _MatrixPageState();
}

class _MatrixPageState extends State<MatrixPage> {
  List<int> get matrix => widget.matrix;
  var _indexSelected = 0;
  var _descriptionCard = '';
  var _infoCard = '';

  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context);
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.header),
        backgroundColor: backgroundColor,
      ),
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
      });
    }, sideLength, isSelected: index == _indexSelected);
  }

  Widget _buildGuideText() {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Text(
            widget.guideText,
            style: matrixNotice,
          ),
        ),
      ),
    );
  }
}
