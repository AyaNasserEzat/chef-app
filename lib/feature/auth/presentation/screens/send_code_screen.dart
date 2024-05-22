import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_assets.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/core/widgets/custom_textFormField.dart';
import 'package:chef_app/feature/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:chef_app/feature/auth/presentation/cubits/forget_password_cubit/forget_password__state.dart';
import 'package:chef_app/feature/auth/presentation/screens/rest_password_screen.dart';
import 'package:chef_app/feature/auth/presentation/screens/signIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendCodeScreen extends StatelessWidget {
  const SendCodeScreen({super.key});

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
              screen: const SignInScreen(),
            );
          }
        ),
        title: Text(
          AppStrings.forgetPassword.tr(
            context,
          ),
          
          style: const TextStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is FailerSendCodeState) {
                showToast(message: state.message, state: ToastStates.error);
              }
              if (state is SucessSendCodeState) {
                showToast(
                    message: AppStrings.checkMail.tr(context), state: ToastStates.success);
                navigateRepacement(
                    context: context, screen: const RestPasswordSreen());
              }
            },
            builder: (context, state) {
              return Form(
                key: BlocProvider.of<ForgetPasswordCubit>(context).sendCodeKey,
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
                      Text(
                        AppStrings.sendResetLinkInfo.tr(context),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      CustomTextFormFeild(
                          hintText: AppStrings.email.tr(context),
                          controller:
                              BlocProvider.of<ForgetPasswordCubit>(context)
                                  .emailSendCodeController),
                      SizedBox(
                        height: 26.h,
                      ),
                      CustomButton(
                          text: AppStrings.sendResetLink.tr(context),
                          onPressed: () {
                            BlocProvider.of<ForgetPasswordCubit>(context)
                                .sendCode();
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
