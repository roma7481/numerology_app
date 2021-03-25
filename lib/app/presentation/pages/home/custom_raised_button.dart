import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    @required this.child,
    @required this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: new BorderRadius.circular(10.0),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            color: Colors.blueGrey,
            child: child,
          ),
        ),
      ),
    );
  }
}
