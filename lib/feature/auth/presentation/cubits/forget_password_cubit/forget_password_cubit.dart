import 'package:chef_app/feature/auth/data/repository/auth_repository.dart';
import 'package:chef_app/feature/auth/presentation/cubits/forget_password_cubit/forget_password__state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this.authRepository) : super(InitialSendCodeState());
  AuthRepository authRepository;
   GlobalKey<FormState> sendCodeKey=GlobalKey<FormState>();
  TextEditingController emailSendCodeController = TextEditingController();
  void sendCode() async {
    emit(LoadingSendCodeState());
    final res = await authRepository.sendCode(
      email: emailSendCodeController.text,
    );
    res.fold((l) => emit(FailerSendCodeState(l)), (r) async {
      emit(SucessSendCodeState());
    });
  }

  GlobalKey<FormState> forgetPasswordKey=GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
   TextEditingController confirmNewPasswordController = TextEditingController();
    TextEditingController codeController = TextEditingController();
  void restPassword() async {
    emit(LoadingRestePasswordState());
    final res = await authRepository.resetPassword(
      email: emailSendCodeController.text,
     password: newPasswordController.text,
     cpassword: confirmNewPasswordController.text,
     code: codeController.text,
    );
    res.fold((l) => emit(FailerRestePasswordState(l)), (r) async {
      emit(SucessRestePasswordState());
    });
  }
}