
import 'package:chef_app/core/GloableCubit/Gloable_cubit.dart';
import 'package:chef_app/core/GloableCubit/gloable_state.dart';
import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_assets.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/feature/auth/presentation/screens/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeLangScreen extends StatelessWidget {
  const ChangeLangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            //background image
           Image.asset(AppAssets.backgroundimag2,width: double.infinity,fit: BoxFit.fill,),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 116.h,
                    ),
                    Image.asset(
                   AppAssets.logo,
                      height: 120.h,
                      width: 120.w,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      AppStrings.welcomeToChefApp.tr(context),
                    style: const TextStyle(color: AppColors.white,fontSize: 27,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      AppStrings.pleaseChooseYourLanguage.tr(context),
                      style: const TextStyle(color: AppColors.white,fontSize: 27),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    BlocBuilder<GlobalCubit, GlobalState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            CustomButton(
                           w: 140.w,
                              text: 'English',
                              onPressed: () {
                                BlocProvider.of<GlobalCubit>(context).changeLang('en');
                                              navigate(context, const SignUupScreen());
                
                              },
                            
                              backgroundColor: Colors.orange[300],
                            ),
                            const Spacer(),
                            CustomButton(
                                 w: 140.w,
                              text: 'العربية',
                              onPressed: () {
                                BlocProvider.of<GlobalCubit>(context).changeLang('ar');
                                navigate(context, const SignUupScreen());
                              },
                           
                              backgroundColor:Colors.orange[300],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}