
import 'package:chef_app/feature/home/presentation/cubits/home_state.dart';
import 'package:chef_app/feature/menu/presentation/screens/menu_screen.dart';
import 'package:chef_app/feature/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit():super(HomeInitialState());
  int curIndx=0;
  List<Widget>screens=[
    const ProfileScreen(),
    const MenuScreen(),
  ];
  void changeIndx(indx){
    curIndx=indx;
    emit(ChangeIndx());
  }
}