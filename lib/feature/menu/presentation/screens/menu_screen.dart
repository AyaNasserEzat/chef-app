import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/feature/menu/presentation/components/menu_screen_component.dart';
import 'package:chef_app/feature/menu/presentation/cubit/menu_cubit.dart';
import 'package:chef_app/feature/menu/presentation/cubit/menu_state.dart';
import 'package:chef_app/feature/menu/presentation/screens/add_menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              CustomButton(
                text: AppStrings.addDishToMenu.tr(context),
                onPressed: () {
                  navigateRepacement(
                      context: context, screen: const AddMenuScreen());
                },
              ),
              BlocBuilder<MenuCubit, MenuState>(
                builder: (context, state) {
                  final menucubit = BlocProvider.of<MenuCubit>(context);
              return    state is LoadingGetChefMealState
                      ?const Center(
                        child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            
                        ),
                      )
                      : menucubit.meals.isEmpty
                          ? Center(
                              child: Text(
                                AppStrings.noMeals.tr(context),
                                style: const TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: menucubit.meals.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MenuItemComponent(
                                      mealModel: menucubit.meals[index],
                                    ),
                                  );
                                },
                              ),
                          
                            );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
