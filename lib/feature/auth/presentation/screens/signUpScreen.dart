import 'dart:io';

import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/core/widgets/custom_circle_avatare.dart';
import 'package:chef_app/core/widgets/custom_textButton.dart';
import 'package:chef_app/core/widgets/custom_textFormField.dart';
import 'package:chef_app/feature/auth/presentation/cubits/signup_cubit/signUp_cubit.dart';
import 'package:chef_app/feature/auth/presentation/cubits/signup_cubit/signUp_state.dart';
import 'package:chef_app/feature/auth/presentation/screens/signIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignUupScreen extends StatelessWidget {
  const SignUupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignUpCubit, SignUpState>(listener: (context, state) {
        if (state is FailerSignUpState) {
          showToast(message: state.message, state: ToastStates.error);
        }
        if (state is SucessSignUpState) {
          showToast(
              message: 'Done, please confirm email',  state: ToastStates.success);
              navigateRepacement(context: context, screen: const SignInScreen());
        }
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: BlocProvider.of<SignUpCubit>(context).sigUPKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  CustomCircleAvatar(
                    backgroundImage:
                        BlocProvider.of<SignUpCubit>(context).profilePic == null
                            ? const AssetImage('assets/images/noProfilePic.jpg')
                            : FileImage(
                                File(BlocProvider.of<SignUpCubit>(context)
                                    .profilePic!
                                    .path),
                              ),
                    onPressed: () {
                      ImagePicker().pickImage(source: ImageSource.gallery).then(
                          (value) => BlocProvider.of<SignUpCubit>(context)
                              .uploadProfilePic(value!));
                    },
                  ),
                  CustomTextFormFeild(
                    hintText: AppStrings.name.tr(context),
                    controller:
                        BlocProvider.of<SignUpCubit>(context).nameController,
                  ),
                
                  CustomTextFormFeild(
                    hintText: AppStrings.email.tr(context),
                    controller:
                        BlocProvider.of<SignUpCubit>(context).emailController,
                    validate: (data) {
                      if (data!.isEmpty || !data.contains('@gmail.com')) {
                        return AppStrings.pleaseEnterValidEmail;
                      }
                      return null;
                    },
                  ),
                   CustomTextFormFeild(
                    hintText: AppStrings.brandName.tr(context),
                    controller:
                        BlocProvider.of<SignUpCubit>(context).bnameController,
                  ),
                  CustomTextFormFeild(
                      hintText: AppStrings.phoneNumber.tr(context),
                      controller: BlocProvider.of<SignUpCubit>(context)
                          .phoneController),
                  CustomTextFormFeild(
                    hintText: AppStrings.password.tr(context),
                    controller: BlocProvider.of<SignUpCubit>(context)
                        .passwordController,
                    isPassword: true,
                    validate: (data) {
                      if (data!.length < 6 || data.isEmpty) {
                        return AppStrings.pleaseEnterValidEmail;
                      }
                      return null;
                    },
                  ),
                  CustomTextFormFeild(
                    hintText: AppStrings.confirmPassword.tr(context),
                    controller: BlocProvider.of<SignUpCubit>(context)
                        .cpasswordController,
                    isPassword: true,
                    validate: (data) {
                      if (data!.length < 6 || data.isEmpty) {
                        return AppStrings.pleaseEnterValidEmail.tr(context);
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  state is LoadingSignUpState
                      ? const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      : CustomButton(
                          text: AppStrings.signUp.tr(context),
                          onPressed: () {
                            if (BlocProvider.of<SignUpCubit>(context)
                                .sigUPKey
                                .currentState!
                                .validate()) {
                              BlocProvider.of<SignUpCubit>(context).signUP();
                            }
                          },
                        ),
                         Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(AppStrings.areadyHaveAnAcount.tr(context),
                                  style: const TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 18,
                                  )),
                              CustomTextButton(
                                  onPressed: () {
                                    navigateRepacement(
                                        context: context,
                                        screen: const SignInScreen());
                                  },
                                  text: AppStrings.signIn.tr(context),
                                  color: AppColors.primaryColor),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
