abstract class MenuState{}
class InitialMenuState extends MenuState{}
class ChangeItemState extends MenuState{}
class ChangeGroubValState extends MenuState{}
class LoadingAddMealState extends MenuState{}
class SucessAddMealState extends MenuState{}
class FailerAddMealState extends MenuState{
  String message;
  FailerAddMealState(this.message);
}

class LoadingGetChefMealState extends MenuState{}
class SucessGetChefMealState extends MenuState{}
class FailerGetChefMealState extends MenuState{
  String message;
  FailerGetChefMealState(this.message);
}

class LoadingDeletfMealState extends MenuState{}
class SucessDeletMealState extends MenuState{}
class FailerDeletMealState extends MenuState{
  String message;
  FailerDeletMealState(this.message);
}
class UploadImage extends MenuState{}