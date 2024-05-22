import 'package:chef_app/core/database/local/cach_helper.dart';
import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/services/services_locator.dart';
import 'package:chef_app/core/utils/app_assets.dart';
import 'package:chef_app/core/utils/app_colors.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/utils/commans.dart';
import 'package:chef_app/feature/auth/presentation/screens/change_land_screen.dart';
import 'package:chef_app/feature/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    natvigateAfterThreeSeconds();
    super.initState();
  }

  void natvigateAfterThreeSeconds() {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      await sl<CacheHelper>().getData(
                key: 'token',
              ) ==
              null
          ? navigate( context, const ChangeLangScreen())
          : navigate(context,const HomeScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logo),
            const SizedBox(
              height: 10,
            ),
             Text(
              AppStrings.chefApp.tr(context),
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
