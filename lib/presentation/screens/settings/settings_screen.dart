import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/font_manager.dart';
import 'package:weather_app/presentation/resources/routes_manager.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsStates>(
      builder: (context, state) {
        SettingsCubit cubit = SettingsCubit.get(context);
        bool isDark = cubit.appearance == Appearance.dark;
        Color color = isDark ? ColorManager.darkPrimaryColor : ColorManager.lightPrimaryColor;

        return Scaffold(
          backgroundColor: color,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color, statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark),
            backgroundColor: color,
            iconTheme: IconThemeData(color: isDark ? ColorManager.white : ColorManager.black),
            title: Text(StringManager.settings, style: getBoldStyle(color: isDark ? ColorManager.white : ColorManager.black, fontSize: FontSize.s22)),
          ),
          body: Column(
            children: [
              InkWell(
                onTap: () => cubit.changeTemperatureUnit(),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(StringManager.temperatureUnit, style: getMediumStyle(color: isDark ? ColorManager.white : ColorManager.black, fontSize: FontSize.s16)),
                      Row(
                        children: [
                          Text(
                            cubit.temperatureUnit == TemperatureUnit.c ? StringManager.celsiusUnit : StringManager.fahrenheitUnit,
                            style: getMediumStyle(color: ColorManager.grey1),
                          ),
                          const SizedBox(width: AppSize.s10),
                          Icon(Icons.arrow_forward_ios, color: ColorManager.grey1, size: AppSize.s16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => cubit.changeAppearance(),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(StringManager.appearance, style: getMediumStyle(color: isDark ? ColorManager.white : ColorManager.black, fontSize: FontSize.s16)),
                      Row(
                        children: [
                          Text(
                            cubit.appearance == Appearance.dark ? StringManager.dark : StringManager.light,
                            style: getMediumStyle(color: ColorManager.grey1),
                          ),
                          const SizedBox(width: AppSize.s10),
                          Icon(Icons.arrow_forward_ios, color: ColorManager.grey1, size: AppSize.s16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(context, Routes.favoriteLocationsRoute),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(StringManager.favoriteLocations, style: getMediumStyle(color: isDark ? ColorManager.white : ColorManager.black, fontSize: FontSize.s16)),
                      Icon(Icons.arrow_forward_ios, color: ColorManager.grey1, size: AppSize.s16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}