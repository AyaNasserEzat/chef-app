abstract class SignUpState{}
class InitialSignUpState extends SignUpState{}
class LoadingSignUpState extends SignUpState{}
class SucessSignUpState extends SignUpState{}
class FailerSignUpState extends SignUpState{
  String message;
  FailerSignUpState(this.message);
}

class LoadingCheckEmailState extends SignUpState{}
class SucessCheckEmailState extends SignUpState{}
class FailerCheckEmailState extends SignUpState{
  String message;
  FailerCheckEmailState(this.message);
}

class UploadProfilePic  extends SignUpState{}