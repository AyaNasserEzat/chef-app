

import 'package:chef_app/core/database/remote/api/end_point.dart';

class LoginModel {
  final String message;
  final String token;

  LoginModel({
    required this.message,
    required this.token,
  });
  factory LoginModel.fromJson(dynamic jsonData) {
    return LoginModel(
      message: jsonData[ApiKeys.message],
      token: jsonData[ApiKeys.token],
    );
  }
}