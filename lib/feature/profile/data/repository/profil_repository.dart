
import 'package:chef_app/core/database/remote/api/api_consumer.dart';
import 'package:chef_app/core/database/remote/api/end_point.dart';
import 'package:chef_app/core/error/exceptions.dart';
import 'package:chef_app/core/services/services_locator.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/feature/profile/data/models/chef_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRepository {
  Future<Either<String, String>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String cpassword,
  }) async {
    try {
      final response =
          await sl<ApiConsumer>().patch(EndPoint.changePassword, data: {
        'oldPass': oldPassword,
        'newPass': newPassword,
        'confirmPassword': cpassword,
      });
      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, ChefModel>> getChefData({required String id}) async {
    try {
      final response = await sl<ApiConsumer>().get(EndPoint.getchefdata(id));
      return Right(ChefModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
  
  Future<Either<String, String>> logout() async {
    try {
      final response = await sl<ApiConsumer>().get(EndPoint.logout);
      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, String>> updateProfile({
    String? name,
    String? phone,
    var location,
    String? brandName,
    String? minCharge,
    XFile? profilePic,
    String? disc,
  }) async {
    try {
      final response = await sl<ApiConsumer>()
          .patch(EndPoint.updteChef, isFormData: true, data: {
        'name': name,
        'phone': phone,
        'location':
            '{"name":"Egypt","address":"meet halfa","coordinates":[1214451511,12541845]}',
        'brandName': brandName,
        'minCharge': minCharge,
        'profilePic': await uploadImageToAPI(profilePic!),
        'disc': disc,
      });
      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
