import 'package:flutter/cupertino.dart';
import 'package:numerology/app/constants/colors.dart';

class ForecastButton extends StatelessWidget {
  ForecastButton({
    @required this.child,
    @required this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: new BorderRadius.circular(17.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          color: tileColor,
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
    );
  }
}
