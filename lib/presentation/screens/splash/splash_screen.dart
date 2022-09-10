import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/presentation/controller/splash/cubit.dart';
import 'package:weather_app/presentation/resources/assets_manager.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/font_manager.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().startDelay(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.defaultPrimaryColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: ColorManager.defaultPrimaryColor, statusBarIconBrightness: Brightness.light),
        backgroundColor: ColorManager.defaultPrimaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(StringManager.weatherApp, style: getBoldStyle(fontSize: FontSize.s36)),
            Lottie.asset(JsonAssets.weatherIc, width: AppSize.s300, height: AppSize.s300, fit: BoxFit.fill),
          ],
        ),
      ),
    );
  }
}