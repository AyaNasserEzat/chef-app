import 'package:chef_app/core/database/local/cach_helper.dart';
import 'package:chef_app/core/database/remote/api/end_point.dart';
import 'package:chef_app/core/services/services_locator.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/feature/profile/data/models/chef_model.dart';
import 'package:chef_app/feature/profile/data/repository/profil_repository.dart';
import 'package:chef_app/feature/profile/presentation/cubits/profile_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubite extends Cubit<ProfileState> {
  ProfileCubite(this.profileRepository) : super(InitialProfileState());
  ProfileRepository profileRepository;
  ChefModel? chefModel;
  GlobalKey<FormState> changeProfileKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void changePassword() async {
    final res = await profileRepository.changePassword(
      oldPassword: oldPasswordController.text,
      newPassword: newPasswordController.text,
      cpassword: confirmNewPasswordController.text,
    );
    res.fold((l) => emit(FailerChangePasswordState(l)),
        (r) => emit(SucessChangePasswordState()));
  }

  void getChefData() async {
    emit(LoadingGetChefDataState());
    final res = await profileRepository.getChefData(
        id: sl<CacheHelper>().getData(key: 'id'));
    res.fold((l) => emit(FailerGetChefDataState(l)), (r) {
      chefModel = r;
      emit(SucessGetChefDataState());
    });
  }

  void logout() async {
    emit(LoadingLogOutState());
    final res = await profileRepository.logout();
    res.fold((l) => emit(FailerLogOutState(l)), (r) async {
      await sl<CacheHelper>().removeData(key: ApiKeys.token);
      emit(SucessLogOutState());
    });
  }

  XFile? profilePic;

  GlobalKey<FormState> updateProfileKey = GlobalKey<FormState>();
  TextEditingController? updateNameController = TextEditingController();
  TextEditingController? updatephoneController = TextEditingController();
  TextEditingController? updateLocationController = TextEditingController();
  TextEditingController? updattMinChargeroller = TextEditingController();
  TextEditingController? updateBrandNameController = TextEditingController();
  TextEditingController? updateDiscController = TextEditingController();
  TextEditingController? updateProfilePicController = TextEditingController();

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePic());
  }

  void updateProfile() async {
    emit(LoadingUpdateProfileState());
    final res = await profileRepository.updateProfile(
      name: updateNameController!.text.isNotEmpty
          ? updateNameController!.text
          : chefModel!.name,
      phone: updatephoneController!.text.isNotEmpty
          ? updatephoneController!.text
          : chefModel!.phone,
      location: updateLocationController!.text.isNotEmpty
          ? updateLocationController!.text
          : chefModel!.location.toString(),
      brandName: updateBrandNameController!.text.isNotEmpty
          ? updateBrandNameController!.text
          : chefModel!.brandName,
      minCharge: updattMinChargeroller!.text.isNotEmpty
          ? updattMinChargeroller!.text
          : chefModel!.minCharge.toString(),
      disc: updateDiscController!.text.isNotEmpty
          ? updateDiscController!.text
          : chefModel!.disc,
      profilePic:
          profilePic != null ? profilePic! : XFile(chefModel!.profilePic),
    );
    res.fold((l) => emit(FailerUpdateProfileState(l)), (r) {
      //getChefData();
      emit(SucessUpdateProfileState());
    });
  }
 
  String groupval = 'ar';
  void changeGroubVal(val) async {
    emit(ChangeLangLoading());
    groupval = val;
    AppStrings.langCode = groupval;
    await sl<CacheHelper>().cacheLanguage(groupval);
    print(AppStrings.langCode);
    emit(ChangeGroubValState());
  }
}
