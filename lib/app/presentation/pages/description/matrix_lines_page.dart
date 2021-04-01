import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/data/language/matrix_tile.dart';

class MatrixLinesPage extends StatelessWidget {
  final String header;
  final String calculation;
  final Map<String, String> description;

  const MatrixLinesPage({
    Key key,
    this.header = '',
    this.calculation = '',
    this.description = const {},
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context);
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(header),
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
          // SliverList(delegate: _buildList(description))
        ],
      ),
    );
  }

  Widget _buildMatrix(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMatrixTile(context),
              _buildMatrixTile(context),
              _buildMatrixTile(context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMatrixTile(context),
              _buildMatrixTile(context),
              _buildMatrixTile(context),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMatrixTile(context),
              _buildMatrixTile(context),
              _buildMatrixTile(context),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMatrixTile(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var sideLength = height * 0.1;
    return buildMatrixTileButton(
      '9999',
      () {},
      sideLength,
    );
  }
}
