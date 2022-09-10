import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/controller/home/states.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/constants_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';
import 'package:weather_app/presentation/widgets/home/air_quality_item.dart';
import 'package:weather_app/presentation/widgets/home/build_title.dart';

class AirQuality extends StatelessWidget {
  const AirQuality({Key? key}) : super(key: key);

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
                const BuildTitle(title: StringManager.airQuality),
                Container(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  decoration: BoxDecoration(
                    color: isDark
                        ? isFoundInTop ? ColorManager.defaultSecondaryColor : ColorManager.darkSecondaryColor
                        : isFoundInTop ? ColorManager.defaultSecondaryColor : ColorManager.lightSecondaryColor,
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(AppSize.s15), bottomLeft: Radius.circular(AppSize.s15), topRight: Radius.circular(AppSize.s15)),
                  ),
                  child: Column(
                    children: [
                      AirQualityItem(text: StringManager.sulphurDioxide, value: '${context.read<HomeCubit>().weatherModel!.current.airQuality.so2.toStringAsFixed(1)} ${ConstantsManager.airQualityValue}'),
                      const SizedBox(height: AppSize.s5),
                      AirQualityItem(text: StringManager.nitrogenDioxide, value: '${context.read<HomeCubit>().weatherModel!.current.airQuality.no2.toStringAsFixed(1)} ${ConstantsManager.airQualityValue}'),
                      const SizedBox(height: AppSize.s5),
                      AirQualityItem(text: StringManager.ozone, value: '${context.read<HomeCubit>().weatherModel!.current.airQuality.o3.toStringAsFixed(1)} ${ConstantsManager.airQualityValue}'),
                      const SizedBox(height: AppSize.s5),
                      AirQualityItem(text: StringManager.carbonMonoxide, value: '${context.read<HomeCubit>().weatherModel!.current.airQuality.co.toStringAsFixed(1)} ${ConstantsManager.airQualityValue}'),
                    ],
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