abstract class SignInState {}
class InitialSignInState extends SignInState{} 
class SucessSignInState extends SignInState{} 
class FailerSignInState extends SignInState{
  String message;
  FailerSignInState(this.message);
} 
class LoadingSignInState extends SignInState{} 