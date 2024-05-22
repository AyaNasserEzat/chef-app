import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_assets.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/core/widgets/custom_textButton.dart';
import 'package:chef_app/core/widgets/custom_textFormField.dart';
import 'package:chef_app/feature/auth/presentation/cubits/signIn_cubit/signin_cubit.dart';
import 'package:chef_app/feature/auth/presentation/cubits/signIn_cubit/signin_state.dart';
import 'package:chef_app/feature/auth/presentation/screens/send_code_screen.dart';
import 'package:chef_app/feature/auth/presentation/screens/signUpScreen.dart';
import 'package:chef_app/feature/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AppAssets.backgroundimage),
                 Text(
                  AppStrings.welcomeBack.tr(context),
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 103.h,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocConsumer<SignInCubit, SignInState>(
                builder: (context, state) {
                  return Form(
                    key: BlocProvider.of<SignInCubit>(context).sigInKey,
                    child: Column(
                      children: [
                        CustomTextFormFeild(
                          hintText: AppStrings.email.tr(context),
                          controller: BlocProvider.of<SignInCubit>(context)
                              .emailController,
                          validate: (data) {
                            if (data!.isEmpty || !data.contains('@gmail.com')) {
                              return AppStrings.pleaseEnterValidEmail;
                            }
                            return null;
                          },
                        ),
                        CustomTextFormFeild(
                          hintText: AppStrings.password.tr(context),
                          controller: BlocProvider.of<SignInCubit>(context)
                              .passwordController,
                          isPassword: true,
                          validate: (data) {
                            if (data!.length < 6 || data.isEmpty) {
                              return AppStrings.pleaseEnterValidPassword.tr(context);
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            CustomTextButton(
                                onPressed: () {
                                  navigateRepacement(
                                      context: context,
                                      screen: const SendCodeScreen());
                                },
                                text: AppStrings.forgetPassword.tr(context),
                                color: AppColors.grey),
                          ],
                        ),
                      state is LoadingSignInState
                      ? const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      :   CustomButton(
                          text: AppStrings.signIn.tr(context),
                          onPressed: () {
                            if (BlocProvider.of<SignInCubit>(context)
                                .sigInKey
                                .currentState!
                                .validate()) {
                              BlocProvider.of<SignInCubit>(context).signin();
                            }
                          },
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Text(AppStrings.dontaveAnAcount.tr(context),
                                  style: const TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 18,
                                  )),
                              CustomTextButton(
                                  onPressed: () {
                                    navigateRepacement(
                                        context: context,
                                        screen: const SignUupScreen());
                                  },
                                  text: AppStrings.signUp.tr(context),
                                  color: AppColors.primaryColor),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                listener: (context, state) {
                  if (state is FailerSignInState) {
                    showToast(message: state.message, state: ToastStates.error);
                  }
                  if (state is SucessSignInState) {
                    showToast(
                        message: AppStrings.loginSucessfully.tr(context), state: ToastStates.success);
                    navigate(context, const HomeScreen());
                  }
                },
              ),
          
             
           
            ),
          ],
        ),
      ),
    );
  }
}
