
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
   CustomCircleAvatar({
    this.backgroundImage,
    this.onPressed,
    super.key,
  });
dynamic backgroundImage;
VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 85,
            backgroundImage: backgroundImage,
          ),
          Positioned(
            bottom: -5,
            right: 5,
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              radius: 25,
              child: IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.camera_alt_outlined,color: AppColors.white,),
              ),
            ),
          ),
        ],
      );
  }
}
