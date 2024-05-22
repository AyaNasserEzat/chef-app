import 'package:chef_app/core/GloableCubit/Gloable_cubit.dart';
import 'package:chef_app/core/GloableCubit/gloable_state.dart';
import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/feature/auth/presentation/screens/spalsh_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return BlocBuilder<GlobalCubit,GlobalState>(
          builder: (context,state) {
            return  MaterialApp(
              localizationsDelegates:const  [
              
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    AppLocalizations.delegate
                  ],
                  supportedLocales: const [
                    Locale('ar', "EG"),
                    Locale('en', "US"),
                  ],
                  locale:Locale( BlocProvider.of<GlobalCubit>(context).lang),
              debugShowCheckedModeBanner: false,
              home:const SplashScreen(),
            );
          }
        );
      },
    );
  }
}
