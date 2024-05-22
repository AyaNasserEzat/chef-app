import 'package:chef_app/feature/auth/data/repository/auth_repository.dart';
import 'package:chef_app/feature/auth/presentation/cubits/signup_cubit/signUp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authRepository) : super(InitialSignUpState());
  final AuthRepository authRepository;
  GlobalKey<FormState> sigUPKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController bnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpasswordController = TextEditingController();
   TextEditingController checkemailController = TextEditingController();
  XFile? profilePic;
 uploadProfilePic(XFile image) {
  profilePic = image;
    emit(UploadProfilePic());
  }
   signUP() async{
    emit(LoadingSignUpState());
  final res= await authRepository.signup(
      name: nameController.text,
      brandName: bnameController.text,
      phone: phoneController.text,
      email: emailController.text,
      password: passwordController.text,
      cpassword: cpasswordController.text,
      profilePic: profilePic!,
      frontId: profilePic!,
      backId: profilePic!,
      healthCertificate: profilePic!,
    );
    res.fold((l) => emit(FailerSignUpState(l)), (r) => emit(SucessSignUpState()));
  }

}
