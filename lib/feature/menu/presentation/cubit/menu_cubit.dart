import 'package:chef_app/feature/menu/data/models/meal_model.dart';
import 'package:chef_app/feature/menu/data/repository/menu_repository.dart';
import 'package:chef_app/feature/menu/presentation/cubit/menu_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit(this.menueRepository) : super(InitialMenuState());
  MenueRepository menueRepository;
  XFile? image;
  List<MealModel> meals=[];
  GlobalKey<FormState> addMenuKey = GlobalKey<FormState>();
  TextEditingController mealNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discController = TextEditingController();
  List categoryList = [
    'Beef',
    'chicken',
    'Fish',
    'Seafood',
    'Pork',
    'Lamp',
    'Vegetarian',
    'Vegan',
    'Gluten-free'
  ];
  String selectedItem = 'Beef';
  void changeItem(item) {
    selectedItem = item;
    emit(ChangeItemState());
  }

  String groupval = 'quantity';
  void changeGroubVal(val) {
    groupval = val;
    emit(ChangeGroubValState());
  }

uploadMealPic(XFile val) {
    image = val;
    emit(UploadImage());
  }

  void addMeal() async {
    emit(LoadingAddMealState());
    final res = await menueRepository.addMeal(
        name: mealNameController.text,
        price: double.parse(
          priceController.text,
        ),
        category: selectedItem,
        mealImage: image,
        disc: discController.text,
        howToSell: groupval);
    res.fold(
        (l) => emit(FailerAddMealState(l)), (r) => emit(SucessAddMealState()));
  }

  void getChefmeal() async {
    emit(LoadingGetChefMealState());
    final res = await menueRepository.getChefmeal();
    res.fold((l) => emit(FailerGetChefMealState(l)), (r) {
      meals = r.meals;
      emit(SucessGetChefMealState());
    });
  }

  void deletemeal(id) async {
    emit(LoadingDeletfMealState());
    final res = await menueRepository.deletemeal(id: id);
    res.fold((l) => emit(FailerDeletMealState(l)), (r) {
      emit(SucessDeletMealState());
    });
  }
}
