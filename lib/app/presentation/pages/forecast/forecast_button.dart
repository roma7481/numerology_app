import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';

class ForecastButton extends StatelessWidget {
  ForecastButton({
    this.isSelected = false,
    @required this.child,
    @required this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;
  final isSelected;

  final radius = 18.0;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: new BorderRadius.circular(radius),
      child: Container(
        decoration: myBoxDecoration(isSelected),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            color: isSelected ? tileColor : tileTransparentColor,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 8.0,
                top: 8.0,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration(bool isSelected) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(
        color: tileColor,
        width: 2,
      ),
    );
  }
}
