import 'package:chef_app/core/database/local/cach_helper.dart';
import 'package:chef_app/core/database/remote/api/end_point.dart';
import 'package:chef_app/core/services/services_locator.dart';
import 'package:chef_app/feature/auth/data/models/signIn_model.dart';
import 'package:chef_app/feature/auth/data/repository/auth_repository.dart';
import 'package:chef_app/feature/auth/presentation/cubits/signIn_cubit/signin_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.authRepository) : super(InitialSignInState());
  final AuthRepository authRepository;
  GlobalKey<FormState> sigInKey=GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginModel? loginModel;
  void signin() async {
    emit(LoadingSignInState());
    final res = await authRepository.signIn(
      email: emailController.text,
      password: passwordController.text,
    );
    res.fold((l) => emit(FailerSignInState(l)), (r) async {
      loginModel=r;
      Map<String,dynamic> decodedToken=JwtDecoder.decode(r.token);
      await sl<CacheHelper>().saveData(key: ApiKeys.token, value:r.token);
     await sl<CacheHelper>().saveData(key: 'id', value: decodedToken['id']);
    // print(decodedToken['id']);
      emit(SucessSignInState());
    });
  }
}
