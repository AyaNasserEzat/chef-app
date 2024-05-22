import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_assets.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/core/widgets/custom_textFormField.dart';
import 'package:chef_app/feature/home/presentation/screens/home_screen.dart';
import 'package:chef_app/feature/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:chef_app/feature/profile/presentation/cubits/profile_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

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
          AppStrings.changePassword.tr(context),
          style: const TextStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<ProfileCubite, ProfileState>(
            listener: (context, state) {
              if (state is FailerChangePasswordState) {
                showToast(message: state.message, state: ToastStates.error);
              }
              if (state is SucessChangePasswordState) {
                showToast(
                    message: AppStrings.passwordChangedSucessfully.tr(context),
                    state: ToastStates.success);
              }
            },
            builder: (context, state) {
              return Form(
                key: BlocProvider.of<ProfileCubite>(context).changeProfileKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Image.asset(AppAssets.lock),
                      SizedBox(
                        height: 24.h,
                      ),
                       Text(AppStrings.changePassword.tr(context)),
                      SizedBox(
                        height: 24.h,
                      ),
                      CustomTextFormFeild(
                          hintText: AppStrings.oldPassword.tr(context),
                          controller: BlocProvider.of<ProfileCubite>(context)
                              .oldPasswordController),
                      CustomTextFormFeild(
                          hintText: AppStrings.newPassword.tr(context),
                          controller: BlocProvider.of<ProfileCubite>(context)
                              .newPasswordController),
                      CustomTextFormFeild(
                        hintText: AppStrings.confirmPassword.tr(context),
                        controller: BlocProvider.of<ProfileCubite>(context)
                            .confirmNewPasswordController,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      CustomButton(
                          text: AppStrings.changePassword.tr(context),
                          onPressed: () {
                            BlocProvider.of<ProfileCubite>(context)
                                .changePassword();
                          })
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
