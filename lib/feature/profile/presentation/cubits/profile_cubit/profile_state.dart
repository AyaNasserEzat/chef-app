abstract class ProfileState{}
class InitialProfileState extends ProfileState{} 
class LoadingUpdateProfileState extends ProfileState{} 
class SucessUpdateProfileState extends ProfileState{} 
class FailerUpdateProfileState extends ProfileState{
  String message;
  FailerUpdateProfileState(this.message);
} 

class InitialChangePasswordState extends ProfileState{} 
class LoadingChangePasswordState extends ProfileState{} 
class SucessChangePasswordState extends ProfileState{} 
class FailerChangePasswordState extends ProfileState{
  String message;
  FailerChangePasswordState(this.message);
} 

class InitialGetChefDataState extends ProfileState{} 
class LoadingGetChefDataState extends ProfileState{} 
class SucessGetChefDataState extends ProfileState{} 
class FailerGetChefDataState extends ProfileState{
  String message;
  FailerGetChefDataState(this.message);
} 

//logout
class InitialLogOutState extends ProfileState{} 
class LoadingLogOutState extends ProfileState{} 
class SucessLogOutState extends ProfileState{} 
class FailerLogOutState extends ProfileState{
  String message;
  FailerLogOutState(this.message);
} 

 class UploadProfilePic extends ProfileState{}
 class ChangeGroubValState extends ProfileState{}
 class ChangeLangLoading extends ProfileState{}
  class ChangeLangSucess extends ProfileState{}