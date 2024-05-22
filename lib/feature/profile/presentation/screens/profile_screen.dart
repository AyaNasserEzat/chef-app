import 'package:cached_network_image/cached_network_image.dart';
import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/core/widgets/custom_aler_dialog.dart';
import 'package:chef_app/feature/auth/presentation/screens/signIn_screen.dart';
import 'package:chef_app/feature/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:chef_app/feature/profile/presentation/cubits/profile_cubit/profile_state.dart';
import 'package:chef_app/feature/profile/presentation/screens/change-password_screen.dart';
import 'package:chef_app/feature/profile/presentation/screens/setting.dart';
import 'package:chef_app/feature/profile/presentation/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<ProfileCubite, ProfileState>(
            listener: (context, state) {
              if(state is SucessLogOutState){
                navigateRepacement(context: context, screen: const SignInScreen());
              }
            },
            builder: (context, state) {
              if (state is SucessGetChefDataState) {
                return Form(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      CachedNetworkImage(
                        imageUrl: BlocProvider.of<ProfileCubite>(context)
                            .chefModel!
                            .profilePic,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 190.w,
                          height: 190.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Text(
                        BlocProvider.of<ProfileCubite>(context).chefModel!.name,
                        style: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 39),
                      ),
                      Text(
                        BlocProvider.of<ProfileCubite>(context)
                            .chefModel!
                            .email,
                        style: const TextStyle(
                            color: AppColors.black, fontSize: 15),
                      ),
                      InkWell(
                        onTap: () {
                          navigateRepacement(
                              context: context,
                              screen: const UpdateProfileScreen());
                        },
                        child: ListTile(
                          leading: const Icon(Icons.person_outlined),
                          title: Text(AppStrings.editProfile.tr(context)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          navigateRepacement(
                              context: context,
                              screen: const ChangePasswordScreen());
                        },
                        child: ListTile(
                          leading: const Icon(Icons.visibility_off),
                          title: Text(AppStrings.password.tr(context)),
                        ),
                      ),
                      InkWell(
                        onTap:() {
                          navigateRepacement(context: context, screen: const SettingScreen());
                        },
                        child: ListTile(
                          leading: const Icon(Icons.settings),
                          title: Text(AppStrings.settings.tr(context)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomAlerDialog(
                                  message: AppStrings.logout.tr(context),
                                  confirmAction: () {
                                    BlocProvider.of<ProfileCubite>(context)
                                        .logout();
                                    Navigator.pop(context);
                                  },
                                );
                              });
                        },
                        child: ListTile(
                          leading: const Icon(Icons.logout),
                          title: Text(AppStrings.logout.tr(context)),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
