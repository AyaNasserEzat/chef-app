import 'package:chef_app/core/GloableCubit/Gloable_cubit.dart';
import 'package:chef_app/core/GloableCubit/gloable_state.dart';
import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/feature/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
            AppStrings.settings.tr(context),
            style: const TextStyle(color: AppColors.white),
          ),
        ),
        body: InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                    ),
                    width: double.infinity,
                    height: 400,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.cancel_sharp),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              AppStrings.language.tr(context),
                              style: const TextStyle(
                                  color: AppColors.grey, fontSize: 27),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 2,
                        ),
                        BlocBuilder<GlobalCubit, GlobalState>(
                            builder: (context, state) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      activeColor: AppColors.primaryColor,
                                      value: 'ar',
                                      groupValue:
                                          BlocProvider.of<GlobalCubit>(
                                                  context)
                                              .lang,
                                      onChanged: (val) {
                                
                                         BlocProvider.of<GlobalCubit>(context).changeLang(val!);
                                             Navigator.pop(context);
                                      }),
                                  const Text(
                                    'العربيه',
                                    style: TextStyle(
                                        color: AppColors.black, fontSize: 27),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      activeColor: AppColors.primaryColor,
                                      value: 'en',
                                      groupValue:
                                          BlocProvider.of<GlobalCubit>(
                                                  context)
                                              .lang,
                                      onChanged: (val) {
                                     
                                             BlocProvider.of<GlobalCubit>(context).changeLang(val!);
                                             Navigator.pop(context);
                                      }),
                                  const Text(
                                    'English',
                                    style: TextStyle(
                                        color: AppColors.black, fontSize: 24),
                                  )
                                ],
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  );
                });
          },
          child: Row(
            children: [
              const Icon(
                Icons.language,
                size: 27,
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                AppStrings.language.tr(context),
                style: const TextStyle(fontSize: 27),
              )
            ],
          ),
        ));
  }
}
