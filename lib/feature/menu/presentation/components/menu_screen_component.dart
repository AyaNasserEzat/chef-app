import 'package:cached_network_image/cached_network_image.dart';
import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/widgets/custom_aler_dialog.dart';
import 'package:chef_app/feature/menu/data/models/meal_model.dart';
import 'package:chef_app/feature/menu/presentation/cubit/menu_cubit.dart';
import 'package:chef_app/feature/menu/presentation/cubit/menu_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MenuItemComponent extends StatelessWidget {
  MenuItemComponent({
    super.key,
    required this.mealModel,
  });
  final MealModel mealModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90.w,
          height: 90.h,
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            imageUrl: mealModel.images[0],
            errorWidget: (context, url, error) => const Icon(Icons.error),
            placeholder: (context, url) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 200,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: 14.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mealModel.name,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            Text(
              mealModel.description,
              style: const TextStyle(fontSize: 16, color: AppColors.grey),
            ),
            Text(
              '${mealModel.price} LE',
              style: const TextStyle(fontSize: 16, color: AppColors.grey),
            ),
          ],
        ),
        const Spacer(),
        BlocConsumer<MenuCubit, MenuState>(listener: (context, state) {
          if (state is SucessDeletMealState) {
            BlocProvider.of<MenuCubit>(context).getChefmeal();
          }
        }, builder: (context, state) {
          return IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomAlerDialog(
                      message: AppStrings.deleteMeal.tr(context),
                      confirmAction: () {
                        BlocProvider.of<MenuCubit>(context)
                            .deletemeal(mealModel.id);
                        Navigator.pop(context);
                        //BlocProvider.of<MenuCubit>(context).getChefmeal();
                      },
                    );
                  });
            },
            icon: const Icon(
              size: 40,
              Icons.cancel_rounded,
              color: Colors.red,
            ),
          );
        }),
      ],
    );
  }
}
