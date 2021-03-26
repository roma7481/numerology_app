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
      body: _buildContext(),
    );
  }

  Widget _buildContext() {
    return CustomScrollView(
      slivers: [
        _buildNumberIcon(),
      ],
    );
  }

  Widget _buildNumberIcon() {
    return SliverToBoxAdapter(
      child: Container(
        color: backgroundColor,
        width: 400,
        height: 400,
        child: CustomPaint(
          painter: OpenPainter(),
        ),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = circleColor
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
    //a circle
    canvas.drawCircle(Offset(200, 200), 65, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}