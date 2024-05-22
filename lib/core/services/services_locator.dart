import 'package:chef_app/core/GloableCubit/Gloable_cubit.dart';
import 'package:chef_app/core/database/local/cach_helper.dart';
import 'package:chef_app/core/database/remote/api/api_consumer.dart';
import 'package:chef_app/core/database/remote/api/api_interceptors.dart';
import 'package:chef_app/core/database/remote/api/dio_consumer.dart';
import 'package:chef_app/feature/auth/data/repository/auth_repository.dart';
import 'package:chef_app/feature/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import 'package:chef_app/feature/auth/presentation/cubits/signIn_cubit/signin_cubit.dart';
import 'package:chef_app/feature/auth/presentation/cubits/signup_cubit/signUp_cubit.dart';
import 'package:chef_app/feature/home/presentation/cubits/home_cubit.dart';
import 'package:chef_app/feature/menu/data/repository/menu_repository.dart';
import 'package:chef_app/feature/menu/presentation/cubit/menu_cubit.dart';
import 'package:chef_app/feature/profile/data/repository/profil_repository.dart';
import 'package:chef_app/feature/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
void initServiceLoactor(){
   sl.registerLazySingleton(()=> CacheHelper());
   sl.registerLazySingleton(()=> AuthRepository());
   sl.registerLazySingleton(()=> ProfileRepository());
   sl.registerLazySingleton(()=> MenueRepository());
   sl.registerLazySingleton(()=> HomeCubit());
   sl.registerLazySingleton(()=> GlobalCubit());
    sl.registerLazySingleton(()=> MenuCubit(sl()));
   sl.registerLazySingleton(()=> SignUpCubit(sl()));
   sl.registerLazySingleton(()=> SignInCubit(sl()));
      sl.registerLazySingleton(()=> ForgetPasswordCubit(sl()));
      sl.registerLazySingleton(()=> ProfileCubite(sl()));
     sl.registerLazySingleton(()=> ApiInterceptors());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(sl()));
  sl.registerLazySingleton(() => Dio());

}