import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/methods.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/controller/home/states.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/constants_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';

class MaxMinTemp extends StatelessWidget {
  const MaxMinTemp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsStates, ChangeAppearanceState>(
      selector: (state) => ChangeAppearanceState(),
      builder: (context, settingsCubit) {
        bool isDark = SettingsCubit.get(context).appearance == Appearance.dark;

        return BlocSelector<HomeCubit, HomeStates, ChangeIsFoundInTopState>(
          selector: (state) => ChangeIsFoundInTopState(),
          builder: (context, state) {
            bool isFoundInTop = HomeCubit.get(context).isFoundInTop;
            bool isCelsius = context.read<SettingsCubit>().temperatureUnit == TemperatureUnit.c;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      isCelsius
                          ? '${context.read<HomeCubit>().weatherModel!.forecast.forecastDay[0].day.maxTempC.toInt()}${ConstantsManager.celsiusSymbol}'
                          : '${context.read<HomeCubit>().weatherModel!.forecast.forecastDay[0].day.maxTempF.toInt()}${ConstantsManager.fahrenheitSymbol}',
                      style: getMediumStyle(
                        color: isDark
                          ? isFoundInTop ? ColorManager.white : ColorManager.white
                          : isFoundInTop ? ColorManager.white : ColorManager.black,
                      ),
                    ),
                    const SizedBox(width: AppSize.s3),
                    Text(
                      ConstantsManager.slashSymbol,
                      style: getMediumStyle(
                        color: isDark
                          ? isFoundInTop ? ColorManager.white : ColorManager.white
                          : isFoundInTop ? ColorManager.white : ColorManager.black,
                      ),
                    ),
                    const SizedBox(width: AppSize.s3),
                    Text(
                      isCelsius
                          ? '${context.read<HomeCubit>().weatherModel!.forecast.forecastDay[0].day.minTempC.toInt()}${ConstantsManager.celsiusSymbol}'
                          : '${context.read<HomeCubit>().weatherModel!.forecast.forecastDay[0].day.minTempF.toInt()}${ConstantsManager.fahrenheitSymbol}',
                      style: getMediumStyle(
                        color: isDark
                          ? isFoundInTop ? ColorManager.white : ColorManager.white
                          : isFoundInTop ? ColorManager.white : ColorManager.black,
                      ),
                    ),
                    const SizedBox(width: AppSize.s10),
                    Text(
                      StringManager.feelsLike,
                      style: getMediumStyle(
                        color: isDark
                            ? isFoundInTop ? ColorManager.white : ColorManager.white
                            : isFoundInTop ? ColorManager.white : ColorManager.black,
                      ),
                    ),
                    const SizedBox(width: AppSize.s3),
                    Text(
                      isCelsius
                          ? '${context.read<HomeCubit>().weatherModel!.current.feelsLikeC.toInt()}${ConstantsManager.celsiusSymbol}'
                          : '${context.read<HomeCubit>().weatherModel!.current.feelsLikeF.toInt()}${ConstantsManager.fahrenheitSymbol}',
                      style: getMediumStyle(
                        color: isDark
                            ? isFoundInTop ? ColorManager.white : ColorManager.white
                            : isFoundInTop ? ColorManager.white : ColorManager.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.s5),
                Text(
                  Methods.formatDate(context.read<HomeCubit>().weatherModel!.location.localtime, 'MMM d E, h:mm a'),
                  style: getMediumStyle(
                    color: isDark
                      ? isFoundInTop ? ColorManager.white : ColorManager.white
                      : isFoundInTop ? ColorManager.white : ColorManager.black,
                  ),
                ),
                const SizedBox(height: AppSize.s30),
              ],
            );
          },
        );
      },
    );
  }
}