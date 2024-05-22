import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({super.key, required this.onPressed, required this.text,this.color});
  VoidCallback? onPressed;
  String text;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: color,fontSize: 18),
        ));
  }
}
