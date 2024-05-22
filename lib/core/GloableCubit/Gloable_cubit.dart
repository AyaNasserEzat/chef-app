import 'package:chef_app/core/GloableCubit/gloable_state.dart';
import 'package:chef_app/core/database/local/cach_helper.dart';
import 'package:chef_app/core/services/services_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());
  String lang = 'ar';
  void changeLang(String codeLang) async {
    emit(ChangeLangLoading());
    lang = codeLang;
    emit(ChangeLangSucess());
  }

  void getCachedLang() {
    emit(ChangeLangLoading());
    final cachedLang = sl<CacheHelper>().getCachedLanguage();
    lang = cachedLang;
    emit(ChangeLangSucess());
  }
}
