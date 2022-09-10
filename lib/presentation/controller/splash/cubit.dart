import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/cache_helper.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/splash/states.dart';
import 'package:weather_app/presentation/resources/constants_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/routes_manager.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitialState());

  static SplashCubit get(context) => BlocProvider.of(context);

  Timer? timer;

  void startDelay(BuildContext context) {
    timer = Timer(const Duration(seconds: ConstantsManager.splashDelay), () => _goNext(context));
  }

  void _goNext(BuildContext context) async {
    timer?.cancel();
    context.read<SettingsCubit>().setTemperatureUnit(convertStringToTemperatureUnit(CacheHelper.getData(key: PREFERENCES_KEY_TEMPERATUREUNIT)));
    context.read<SettingsCubit>().setAppearance(convertStringToAppearance(CacheHelper.getData(key: PREFERENCES_KEY_APPEARANCE)));
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
  }
}