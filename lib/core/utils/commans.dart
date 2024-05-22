
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
void navigate(BuildContext context,Widget screen){
  Navigator.push(context, MaterialPageRoute(builder: (context){return screen;}));
}
void navigateRepacement({
  required BuildContext context,
  required Widget screen,
  dynamic arg,
}) {
  Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context){return screen;}));
}
void showToast({
  required String message,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: getState(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { error, success, warining }

Color getState(ToastStates state) {
  switch (state) {
    case ToastStates.error:
      return AppColors.red;
    case ToastStates.success:
      return AppColors.green;
    case ToastStates.warining:
      return AppColors.primaryColor;
  }
}
Future uploadImageToAPI(XFile image) async {
  return  MultipartFile.fromFile(image.path,
      filename: image.path.split('/').last);

}