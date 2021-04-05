import 'package:flutter/material.dart';
import 'package:numerology/app/data/language/matrix_tile.dart';

Widget buildMatrix(BuildContext context, List<int> matrix) {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMatrixTile(context, matrix[0]),
            _buildMatrixTile(context, matrix[3]),
            _buildMatrixTile(context, matrix[6]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMatrixTile(context, matrix[1]),
            _buildMatrixTile(context, matrix[4]),
            _buildMatrixTile(context, matrix[7]),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMatrixTile(context, matrix[2]),
            _buildMatrixTile(context, matrix[5]),
            _buildMatrixTile(context, matrix[8]),
          ],
        )
      ],
    ),
  );
}

Widget _buildMatrixTile(BuildContext context, int lineSum) {
  var height = MediaQuery.of(context).size.height;
  var sideLength = height * 0.1;
  return buildMatrixTileButton(
    lineSum.toString().replaceAll('0', '-'),
    () {},
    sideLength,
  );
}
