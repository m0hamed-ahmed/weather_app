import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/controller/home/states.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';
import 'package:weather_app/presentation/widgets/home/build_title.dart';
import 'package:weather_app/presentation/widgets/home/hour_item.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({Key? key}) : super(key: key);

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
                const BuildTitle(title: StringManager.hourlyForecast),
                Container(
                  height: AppSize.s160,
                  decoration: BoxDecoration(
                    color: isDark
                      ? isFoundInTop ? ColorManager.defaultSecondaryColor : ColorManager.darkSecondaryColor
                      : isFoundInTop ? ColorManager.defaultSecondaryColor : ColorManager.lightSecondaryColor,
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(AppSize.s15), bottomLeft: Radius.circular(AppSize.s15), topRight: Radius.circular(AppSize.s15)),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5, vertical: AppPadding.p15),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => HourItem(hourModel: context.read<HomeCubit>().weatherModel!.forecast.forecastDay[0].hour[index]),
                    separatorBuilder: (context, index) => const SizedBox(width: AppSize.s10),
                    itemCount: context.read<HomeCubit>().weatherModel!.forecast.forecastDay[0].hour.length,
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