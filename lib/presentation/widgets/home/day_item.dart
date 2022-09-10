import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:weather_app/core/utils/methods.dart';
import 'package:weather_app/data/models/forecast_day_model.dart';
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

class DayItem extends StatelessWidget {
  final ForecastDayModel forecastDayModel;

  const DayItem({Key? key, required this.forecastDayModel}) : super(key: key);

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

            return LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.25,
                      child: Text(
                        forecastDayModel.date == intl.DateFormat('yyyy-MM-dd').format(DateTime.now())
                            ? StringManager.today
                            : forecastDayModel.date == intl.DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 1)))
                            ? StringManager.tomorrow
                            : Methods.formatDate('${forecastDayModel.date} 00:00', 'MMM d E'),
                        style: getMediumStyle(
                            color: isDark
                                ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                                : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor
                        ),
                      ),
                    ),
                    Image.network('${ConstantsManager.https}${forecastDayModel.day.condition.icon}', width: AppSize.s40, height: AppSize.s40),
                    const SizedBox(width: AppSize.s5),
                    SizedBox(
                      width: constraints.maxWidth * 0.20,
                      child: Text(
                        forecastDayModel.day.condition.text,
                        style: getMediumStyle(
                          color: isDark
                              ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                              : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.s5),
                    Row(
                      children: [
                        Text(
                          isCelsius
                              ? '${forecastDayModel.day.maxTempC.toInt()}${ConstantsManager.celsiusSymbol}'
                              : '${forecastDayModel.day.maxTempF.toInt()}${ConstantsManager.fahrenheitSymbol}',
                          style: getMediumStyle(
                            color: isDark
                                ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                                : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor
                          ),
                        ),
                        const SizedBox(width: AppSize.s3),
                        Text(
                          ConstantsManager.slashSymbol,
                          style: getMediumStyle(
                            color: isDark
                                ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                                : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor
                          ),
                        ),
                        const SizedBox(width: AppSize.s3),
                        Text(
                          isCelsius
                              ? '${forecastDayModel.day.minTempC.toInt()}${ConstantsManager.celsiusSymbol}'
                              : '${forecastDayModel.day.minTempF.toInt()}${ConstantsManager.fahrenheitSymbol}',
                          style: getMediumStyle(
                            color: isDark
                                ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                                : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: AppSize.s5),
                    Row(
                      children: [
                        Icon(Icons.water_drop, size: AppSize.s14, color: ColorManager.blueGreyLight1),
                        const SizedBox(width: AppSize.s2),
                        Text(
                          '${forecastDayModel.day.dailyChanceOfRain.toInt()}${ConstantsManager.percentageSymbol}',
                          style: getMediumStyle(
                            color: isDark
                                ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                                : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}