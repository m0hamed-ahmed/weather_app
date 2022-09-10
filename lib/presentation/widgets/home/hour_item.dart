import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/methods.dart';
import 'package:weather_app/data/models/hour_model.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/controller/home/states.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/constants_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';

class HourItem extends StatelessWidget {
  final HourModel hourModel;

  const HourItem({Key? key, required this.hourModel}) : super(key: key);

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
              children: [
                SizedBox(
                  height: AppSize.s20,
                  child: Text(
                    Methods.formatDate(hourModel.time, 'h a'),
                    style: getMediumStyle(
                      color: isDark
                          ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                          : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s60,
                  child: Image.network('${ConstantsManager.https}${hourModel.condition.icon}', width: AppSize.s50, height: AppSize.s50),
                ),
                SizedBox(
                  height: AppSize.s20,
                  child: Text(
                    isCelsius
                        ? '${hourModel.tempC.toInt()}${ConstantsManager.celsiusSymbol}'
                        : '${hourModel.tempF.toInt()}${ConstantsManager.fahrenheitSymbol}',
                    style: getMediumStyle(
                      color: isDark
                          ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                          : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s30,
                  child: Row(
                    children: [
                      Icon(Icons.water_drop, size: AppSize.s14, color: ColorManager.blueGreyLight1),
                      const SizedBox(width: AppSize.s2),
                      Text(
                        '${hourModel.chanceOfRain.toInt()}${ConstantsManager.percentageSymbol}',
                        style: getMediumStyle(
                          color: isDark
                              ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                              : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}