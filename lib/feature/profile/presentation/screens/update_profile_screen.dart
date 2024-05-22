import 'dart:io';

import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/core/widgets/custom_circle_avatare.dart';
import 'package:chef_app/core/widgets/custom_textFormField.dart';
import 'package:chef_app/feature/home/presentation/screens/home_screen.dart';
import 'package:chef_app/feature/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:chef_app/feature/profile/presentation/cubits/profile_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

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
          title:  Text(
            AppStrings.editProfile.tr(context),
            style: const TextStyle(color: AppColors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: BlocConsumer<ProfileCubite, ProfileState>(
                  listener: (context, state) {
                if (state is FailerChangePasswordState) {
                  showToast(message: state.message, state: ToastStates.error);
                }
                if (state is SucessUpdateProfileState) {
                  showToast(
                      message: 'profile updated sucessfully',
                      state: ToastStates.success);
                       BlocProvider.of<ProfileCubite>(context).getChefData();
                navigateRepacement(context: context, screen: const HomeScreen());
                }
               

              }, builder: (context, state) {
                return Form(
                  key: BlocProvider.of<ProfileCubite>(context).updateProfileKey,
                  child: Column(
                    children: [
                      CustomCircleAvatar(
                        backgroundImage: BlocProvider.of<ProfileCubite>(context)
                                    .profilePic ==
                                null
                            ? NetworkImage(
                                BlocProvider.of<ProfileCubite>(context)
                                    .chefModel!
                                    .profilePic,
                              )
                            : FileImage(
                                File(BlocProvider.of<ProfileCubite>(context)
                                    .profilePic!
                                    .path),
                              ),
                        onPressed: () {
                          ImagePicker()
                              .pickImage(source: ImageSource.gallery)
                              .then((value) =>
                                  BlocProvider.of<ProfileCubite>(context)
                                      .uploadProfilePic(value!));
                        },
                      ),
                      CustomTextFormFeild(
                        hintText: AppStrings.name.tr(context),
                        controller: BlocProvider.of<ProfileCubite>(context)
                            .updateNameController,
                      ),
                      CustomTextFormFeild(
                          hintText: AppStrings.phoneNumber.tr(context),
                          controller: BlocProvider.of<ProfileCubite>(context)
                              .updatephoneController),
                      CustomTextFormFeild(
                          hintText: AppStrings.brandName.tr(context),
                          controller: BlocProvider.of<ProfileCubite>(context)
                              .updateBrandNameController),
                      CustomTextFormFeild(
                          hintText: AppStrings.minCharge.tr(context),
                          controller: BlocProvider.of<ProfileCubite>(context)
                              .updattMinChargeroller),
                      CustomTextFormFeild(
                          hintText: AppStrings.description.tr(context),
                          controller: BlocProvider.of<ProfileCubite>(context)
                              .updateDiscController),
                      // CustomTextFormFeild(
                      //   hintText: AppStrings.location,
                      //   controller: BlocProvider.of<ProfileCubite>(context)
                      //       .updateLocationController,
                      // ),
                      const SizedBox(
                        height: 16,
                      ),
                   state is LoadingUpdateProfileState
                      ? const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      :      CustomButton(
                          text: AppStrings.update.tr(context),
                          onPressed: () {
                            BlocProvider.of<ProfileCubite>(context)
                                .updateProfile();
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
