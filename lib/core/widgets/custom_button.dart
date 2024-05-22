import 'package:chef_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      required this.text,
      this.textcolor,
      required this.onPressed,
      this.w,
      this.h,
      this.backgroundColor});
  String text;
  Color? textcolor;
  VoidCallback? onPressed;
  Color? backgroundColor;
  double? w;double? h;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h,width: w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          
          fixedSize: const Size(340, 35),
              
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: textcolor ?? AppColors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
