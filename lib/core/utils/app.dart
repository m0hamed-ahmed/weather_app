import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/my_behavior.dart';
import 'package:weather_app/presentation/controller/favorite_locations/cubit.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/splash/cubit.dart';
import 'package:weather_app/presentation/resources/routes_manager.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => SettingsCubit()),
        BlocProvider(create: (context) => FavoriteLocationsCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringManager.appName,
        theme: getApplicationTheme(),
        initialRoute: Routes.splashRoute,
        onGenerateRoute: RouteGenerator.getRoute,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
      ),
    );
  }
}