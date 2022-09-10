import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/controller/home/states.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/constants_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/font_manager.dart';
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';

class CurrentTemp extends StatelessWidget {
  const CurrentTemp({Key? key}) : super(key: key);

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
                    BlocSelector<HomeCubit, HomeStates, ChangeFontSizeWhenScrollingState>(
                      selector: (state) => ChangeFontSizeWhenScrollingState(),
                      builder: (context, state) {
                        return Text(
                          isCelsius
                            ? '${context.read<HomeCubit>().weatherModel!.current.tempC.toInt()}'
                            : '${context.read<HomeCubit>().weatherModel!.current.tempF.toInt()}',
                          style: getLightStyle(
                            color: isDark
                              ? isFoundInTop ? ColorManager.white : ColorManager.white
                              : isFoundInTop ? ColorManager.white : ColorManager.black,
                            fontSize: context.read<HomeCubit>().fontSize,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: AppSize.s10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isCelsius ? ConstantsManager.celsiusSymbol : ConstantsManager.fahrenheitSymbol,
                            style: getMediumStyle(
                            color: isDark
                                ? isFoundInTop ? ColorManager.white : ColorManager.white
                                : isFoundInTop ? ColorManager.white : ColorManager.black,
                              fontSize: FontSize.s22
                            ),
                          ),
                          const SizedBox(height: AppSize.s5),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  context.read<HomeCubit>().weatherModel!.current.condition.text,
                                  style: getMediumStyle(
                                    color: isDark
                                        ? isFoundInTop ? ColorManager.white : ColorManager.white
                                        : isFoundInTop ? ColorManager.white : ColorManager.black,
                                    fontSize: FontSize.s22
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Image.network('${ConstantsManager.https}${context.read<HomeCubit>().weatherModel!.current.condition.icon}'),
                  ],
                ),
                const SizedBox(height: AppSize.s10),
              ],
            );
          },
        );
      },
    );
  }
}