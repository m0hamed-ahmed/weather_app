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

class BuildTitle extends StatelessWidget {
  final String title;
  final bool isAllBorderRadius;
  final bool isInfinityWidth;

  const BuildTitle({
    Key? key,
    required this.title,
    this.isAllBorderRadius = false,
    this.isInfinityWidth  = false,
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
              width: isInfinityWidth ? double.infinity : null,
              padding: const EdgeInsets.all(AppPadding.p15),
              decoration: BoxDecoration(
                color: isDark
                    ? isFoundInTop ? ColorManager.defaultSecondaryColor : ColorManager.darkSecondaryColor
                    : isFoundInTop ? ColorManager.defaultSecondaryColor : ColorManager.lightSecondaryColor,
                borderRadius: isAllBorderRadius
                    ? BorderRadius.circular(AppSize.s15)
                    : const BorderRadius.only(topRight: Radius.circular(AppSize.s15), topLeft: Radius.circular(AppSize.s15)),
              ),
              child: Text(
                title,
                style: getMediumStyle(
                  fontSize: FontSize.s18,
                  color: isDark
                    ? isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.lightSecondaryColor
                    : isFoundInTop ? ColorManager.lightSecondaryColor : ColorManager.darkSecondaryColor,
                ),
              ),
            );
          },
        );
      },
    );
  }
}