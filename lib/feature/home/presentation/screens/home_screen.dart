import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/feature/home/presentation/cubits/home_cubit.dart';
import 'package:chef_app/feature/home/presentation/cubits/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context,state) {
        return Scaffold(
          body:BlocProvider.of<HomeCubit>(context).screens[BlocProvider.of<HomeCubit>(context).curIndx],
          bottomNavigationBar: BottomNavigationBar(

            currentIndex:BlocProvider.of<HomeCubit>(context).curIndx ,
            onTap: (value){
              BlocProvider.of<HomeCubit>(context).changeIndx(value);
            },
          unselectedItemColor: AppColors.grey,
selectedItemColor: AppColors.primaryColor,
            items:  [
              BottomNavigationBarItem(icon: const Icon(Icons.person,), label: AppStrings.profile.tr(context),),
              BottomNavigationBarItem(icon: const Icon(Icons.menu,), label: AppStrings.menu.tr(context),)
            ],
          ),
        );
      }
    );
  }
}
