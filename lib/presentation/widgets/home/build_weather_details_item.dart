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

class BuildWeatherDetailsItem extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  final int shape;

  const BuildWeatherDetailsItem({
    Key? key,
    required this.image,
    required this.title,
    required this.text,
    required this.shape,
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

            return Container(
              padding: const EdgeInsets.all(AppPadding.p10),
              decoration: BoxDecoration(
                color: isDark
                    ? isFoundInTop ? ColorManager.defaultSecondaryColor : ColorManager.darkSecondaryColor
                    : isFoundInTop ? ColorManager.defaultSecondaryColor : ColorManager.lightSecondaryColor,
                borderRadius: BorderRadius.circular(AppSize.s15),
              ),
              child: shape == 1
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    image,
                    width: AppSize.s50,
                    height: AppSize.s50,
                    color: isDark
                        ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                        : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor,
                  ),
                  const SizedBox(width: AppSize.s10),
                  Column(
                    children: [
                      Text(
                        title,
                        style: getBoldStyle(
                          fontSize: FontSize.s16,
                          color: isDark
                              ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                              : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor,
                        ),
                      ),
                      const SizedBox(height: AppSize.s10),
                      Text(
                        text,
                        style: getBoldStyle(
                          fontSize: FontSize.s16,
                          color: isDark
                              ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                              : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: getBoldStyle(
                          fontSize: FontSize.s16,
                          color: isDark
                              ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                              : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      text,
                      style: getBoldStyle(
                        fontSize: FontSize.s20,
                        color: isDark
                            ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                            : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}