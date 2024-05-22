import 'package:chef_app/app/app.dart';
import 'package:chef_app/core/GloableCubit/Gloable_cubit.dart';
import 'package:chef_app/core/database/local/cach_helper.dart';
import 'package:chef_app/core/services/services_locator.dart';
import 'package:chef_app/feature/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:chef_app/feature/auth/presentation/cubits/signIn_cubit/signin_cubit.dart';
import 'package:chef_app/feature/auth/presentation/cubits/signup_cubit/signUp_cubit.dart';
import 'package:chef_app/feature/home/presentation/cubits/home_cubit.dart';
import 'package:chef_app/feature/menu/presentation/cubit/menu_cubit.dart';
import 'package:chef_app/feature/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLoactor();
  await sl<CacheHelper>().init();

  runApp(MultiBlocProvider(providers: [
      BlocProvider(
      create: (context) => sl<SignUpCubit>(),
    ),
    BlocProvider(
      create: (context) => sl<SignInCubit>(),
    ),
     BlocProvider(
      create: (context) => sl<ForgetPasswordCubit>(),
    ),
     BlocProvider(
      create: (context) => sl<HomeCubit>(),
    ),
    BlocProvider(
      create: (context) => sl<GlobalCubit>(),//..getCachedLang(),
    ),
      BlocProvider(
      create: (context) => sl<ProfileCubite>()..getChefData(),
    ),
        BlocProvider(
      create: (context) => sl<MenuCubit>()..getChefmeal(),
    ),
  ], child: const MyApp()));
}
