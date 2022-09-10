import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/controller/home/states.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/font_manager.dart';
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';

class AirQualityItem extends StatelessWidget {
  final String text;
  final String value;

  const AirQualityItem({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: isDark
                          ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                          : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor
                  ),
                ),
                const SizedBox(height: AppSize.s10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    value,
                    style: getBoldStyle(
                        fontSize: FontSize.s20,
                        color: isDark
                            ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                            : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor
                    ),
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