import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';

class DescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context);
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Number'),
        backgroundColor: backgroundColor,
      ),
      body: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          _buildNumberIcon(context),
        ],
      ),
    );
  }

  Widget _buildNumberIcon(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SliverToBoxAdapter(
      child: Container(
        width: 400,
        height: 200,
        child: CustomPaint(
          painter: OpenPainter(width, height),
        ),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  final double width;
  final double height;

  OpenPainter(this.width, this.height);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = circleColor
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    var radius = 65.0;
    var center = Offset((width)* 0.5, 100);
    canvas.drawCircle(center, radius, paint);

    final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: '23',
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: size.width - 12.0 - 12.0);
    textPainter.paint(canvas, Offset((size.width - textPainter.width) * 0.5, 95));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}