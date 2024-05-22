import 'package:chef_app/core/database/local/cach_helper.dart';
import 'package:chef_app/core/database/remote/api/api_consumer.dart';
import 'package:chef_app/core/database/remote/api/end_point.dart';
import 'package:chef_app/core/error/exceptions.dart';
import 'package:chef_app/core/services/services_locator.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/feature/menu/data/models/meal_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

class MenueRepository {
  Future<Either<String, String>> addMeal({
    required String? name,
    required double? price,
    required String? category,
    required String? disc,
    required XFile? mealImage,
    required String howToSell,
  }) async {
    try {
      final response = await sl<ApiConsumer>().post(EndPoint.addMeal, isFormData: true,data: {
        'name': name,
        'price': price,
        'category': category,
        'description': disc,
        'howToSell': howToSell,
        'mealImages': await uploadImageToAPI(mealImage!),
      });
      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, GetAllMealsModel>> getChefmeal() async {
    try {
      final response = await sl<ApiConsumer>().get(EndPoint.getchefmeal(sl<CacheHelper>().getData(key: 'id')));
      return Right(GetAllMealsModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, String>> deletemeal({required String id}) async {
    try {
      final response = await sl<ApiConsumer>().delete(EndPoint.deletemeal(id));
      return Right(response['message']);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
