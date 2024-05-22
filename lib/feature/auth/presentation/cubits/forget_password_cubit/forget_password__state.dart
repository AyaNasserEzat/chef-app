abstract class ForgetPasswordState {}
class InitialSendCodeState extends ForgetPasswordState{} 
class LoadingSendCodeState extends ForgetPasswordState{} 
class SucessSendCodeState extends ForgetPasswordState{} 
class FailerSendCodeState extends ForgetPasswordState{
  String message;
  FailerSendCodeState(this.message);
} 


class LoadingRestePasswordState extends ForgetPasswordState{} 
class SucessRestePasswordState extends ForgetPasswordState{} 
class FailerRestePasswordState extends ForgetPasswordState{
  String message;
  FailerRestePasswordState(this.message);
} 
