import 'package:chef_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormFeild extends StatefulWidget {
  CustomTextFormFeild(
      {super.key,
      this.label,
      required this.hintText,
      required this.controller,
      this.isPassword,
      this.suffixIcon,
      this.validate});
  Widget? label;
  String hintText;
  TextEditingController? controller;
  Widget? suffixIcon;
  bool? isPassword;
 final String? Function(String?)? validate;
  @override
  State<CustomTextFormFeild> createState() => _CustomTextFormFeildState();
}

class _CustomTextFormFeildState extends State<CustomTextFormFeild> {
  bool _isHidden=true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        validator:widget.validate ,
        obscureText: widget.isPassword==true?_isHidden:false,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword == true
                ? IconButton(
                    onPressed: () {
                      _togglePasswordView();
                    },
                    icon: _isHidden == true
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    color: AppColors.primaryColor ,
                  )
                : null,
          label: widget.label,
          hintText: widget.hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
  void _togglePasswordView(){
    setState(() {
      _isHidden=!_isHidden;
    });
  }
}
