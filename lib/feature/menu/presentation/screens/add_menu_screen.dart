import 'dart:io';
import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/core/widgets/custom_circle_avatare.dart';
import 'package:chef_app/core/widgets/custom_textFormField.dart';
import 'package:chef_app/feature/home/presentation/screens/home_screen.dart';
import 'package:chef_app/feature/menu/presentation/cubit/menu_cubit.dart';
import 'package:chef_app/feature/menu/presentation/cubit/menu_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddMenuScreen extends StatelessWidget {
  const AddMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.white,
            ),
            onPressed: () {
              navigateRepacement(
                context: context,
                screen: const HomeScreen(),
              );
            },
          ),
          title: Text(
            AppStrings.addDishToMenu.tr(context),
            style: const TextStyle(color: AppColors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: BlocConsumer<MenuCubit, MenuState>(
                  listener: (context, state) {
                if (state is FailerAddMealState) {
                  showToast(message: state.message, state: ToastStates.error);
                }
                if (state is SucessAddMealState) {
                  showToast(
                      message: AppStrings.mealAddedSucessfully.tr(context),
                      state: ToastStates.success);

                  navigateRepacement(
                      context: context, screen: const HomeScreen());
                  BlocProvider.of<MenuCubit>(context).getChefmeal();
                }
              }, builder: (context, state) {
                final menucubit = BlocProvider.of<MenuCubit>(context);
                return Form(
                  key: menucubit.addMenuKey,
                  child: Column(
                    children: [
                      CustomCircleAvatar(
                        backgroundImage: menucubit.image == null
                            ? const AssetImage(
                                "assets/images/nomeal.png",
                              )
                            : FileImage(
                                File(menucubit.image!.path),
                              ),
                        onPressed: () {
                          ImagePicker()
                              .pickImage(source: ImageSource.gallery)
                              .then((value) => menucubit.uploadMealPic(value!));
                        },
                      ),
                      CustomTextFormFeild(
                        hintText: AppStrings.name,
                        controller: menucubit.mealNameController,
                      ),
                      CustomTextFormFeild(
                          hintText: AppStrings.mealPrice.tr(context),
                          controller: menucubit.priceController),
                      CustomTextFormFeild(
                          hintText: AppStrings.description,
                          controller: menucubit.discController),
                      SizedBox(
                        height: 48.h,
                        width: double.infinity,
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text(AppStrings.category.tr(context)),
                          value: menucubit.selectedItem,
                          items: BlocProvider.of<MenuCubit>(context)
                              .categoryList
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (data) {
                            menucubit.changeItem(data);
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                  activeColor: AppColors.primaryColor,
                                  value: 'quantity',
                                  groupValue: menucubit.groupval,
                                  onChanged: (val) {
                                    menucubit.changeGroubVal(val);
                                  }),
                              Text(AppStrings.mealQuantity.tr(context))
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  activeColor: AppColors.primaryColor,
                                  value: 'number',
                                  groupValue: menucubit.groupval,
                                  onChanged: (val) {
                                    menucubit.changeGroubVal(val);
                                  }),
                              Text(AppStrings.mealNumber.tr(context))
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      state is LoadingAddMealState
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : CustomButton(
                              text: AppStrings.addDishToMenu.tr(context),
                              onPressed: () {
                                menucubit.addMeal();
                              }),
                    ],
                  ),
                );
              }),
            ),
          ),
        ));
  }
}
