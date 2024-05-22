import 'package:chef_app/core/database/remote/api/api_consumer.dart';
import 'package:chef_app/core/database/remote/api/end_point.dart';
import 'package:chef_app/core/error/exceptions.dart';
import 'package:chef_app/core/services/services_locator.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/feature/auth/data/models/signIn_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class AuthRepository {
  Future<Either<String, LoginModel>> signIn(
      {required String email, required String password}) async {
    try {
      final response = await sl<ApiConsumer>().post(EndPoint.chefsignIn, data: {
        'email': email,
        'password': password,
      });
      return Right(LoginModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, String>> signup({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String cpassword,
    required XFile profilePic,
    String? brandName,
    String? minCharge,
    XFile? frontId,
    XFile? backId,
    XFile? healthCertificate,
  }) async {
    try {
      final respons = await sl<ApiConsumer>()
          .post(EndPoint.signUp, 
          isFormData: true, 
          data: {
        'profilePic': await uploadImageToAPI(profilePic),
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'confirmPassword': cpassword,
        'location':
            '{"name":"methalfa","address":"meet halfa","coordinates":[1214451511,12541845]}',
        'brandName': brandName,
        'minCharge': '150',
        'disc':
            'gooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo',
        'healthCertificate':await uploadImageToAPI(profilePic),
       'frontId':await uploadImageToAPI(profilePic),
      'backId':await uploadImageToAPI(profilePic),
     });
      return Right(respons['message']);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
  Future<Either<String, String>> sendCode({required String email}) async {
    try {
      final response = await sl<ApiConsumer>().post(EndPoint.sendCode, data: {
        'email': email,
      });
      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, String>> resetPassword(
      {required String email,
      required String password,
      required String cpassword,
      required String code}) async {
    try {
      final response =
          await sl<ApiConsumer>().patch(EndPoint.resetPassword, data: {
        'email': email,
        'password': password,
        'confirmPassword': cpassword,
        'code': code,
      });
      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
