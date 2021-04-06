import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';

class CompatCircle extends CustomPainter {
  final BuildContext context;
  final String text;

  CompatCircle(this.context, this.text);

  @override
  void paint(Canvas canvas, Size size) {
    double width = MediaQuery.of(context).size.width;

    var paint = Paint()
      ..color = circleColor
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    var radius = 30.0;
    var center = Offset((width) * 0.2, 40);
    canvas.drawCircle(center, radius, paint);

    final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: calcNumberCompat,
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: size.width - 12.0 - 12.0);
    textPainter.paint(
        canvas,
        Offset((size.width - textPainter.width) * 0.19,
            40 - textPainter.height * 0.6));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
