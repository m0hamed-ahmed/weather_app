import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/resources/assets_manager.dart';
import 'package:weather_app/presentation/resources/constants_manager.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';
import 'package:weather_app/presentation/widgets/home/build_title.dart';
import 'package:weather_app/presentation/widgets/home/build_weather_details_item.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BuildTitle(title: StringManager.weatherDetails, isAllBorderRadius: true, isInfinityWidth: true),
        const SizedBox(height: AppSize.s10),
        Row(
          children: [
            Expanded(
              child: BuildWeatherDetailsItem(
                image: ImageAssets.sunrise,
                title: StringManager.sunrise,
                text: context.read<HomeCubit>().weatherModel!.forecast.forecastDay[0].astro.sunrise,
                shape: 1,
              ),
            ),
            const SizedBox(width: AppSize.s10),
            Expanded(
              child: BuildWeatherDetailsItem(
                image: ImageAssets.sunset,
                title: StringManager.sunset,
                text: context.read<HomeCubit>().weatherModel!.forecast.forecastDay[0].astro.sunset,
                shape: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s10),
        Row(
          children: [
            Expanded(
              child: BuildWeatherDetailsItem(
                image: ImageAssets.moonrise,
                title: StringManager.moonrise,
                text: context.read<HomeCubit>().weatherModel!.forecast.forecastDay[0].astro.moonrise,
                shape: 1,
              ),
            ),
            const SizedBox(width: AppSize.s10),
            Expanded(
              child: BuildWeatherDetailsItem(
                image: ImageAssets.moonset,
                title: StringManager.moonset,
                text: context.read<HomeCubit>().weatherModel!.forecast.forecastDay[0].astro.moonset,
                shape: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s10),
        Row(
          children: [
            Expanded(
              child: BuildWeatherDetailsItem(
                image: ImageAssets.wind,
                title: StringManager.wind,
                text: '${context.read<HomeCubit>().weatherModel!.current.windDir} ${context.read<HomeCubit>().weatherModel!.current.windKph.toInt()} ${ConstantsManager.kilometresPerHour}',
                shape: 2,
              ),
            ),
            const SizedBox(width: AppSize.s10),
            Expanded(
              child: BuildWeatherDetailsItem(
                image: ImageAssets.humidity,
                title: StringManager.humidity,
                text: '${context.read<HomeCubit>().weatherModel!.current.humidity.toInt()}${ConstantsManager.percentageSymbol}',
                shape: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s10),
        Row(
          children: [
            Expanded(
              child: BuildWeatherDetailsItem(
                image: ImageAssets.cloud,
                title: StringManager.cloud,
                text: '${context.read<HomeCubit>().weatherModel!.current.cloud}${ConstantsManager.percentageSymbol}',
                shape: 2,
              ),
            ),
            const SizedBox(width: AppSize.s10),
            Expanded(
              child: BuildWeatherDetailsItem(
                image: ImageAssets.pressure,
                title: StringManager.pressure,
                text: '${context.read<HomeCubit>().weatherModel!.current.pressureMb.toInt()} ${ConstantsManager.millibars}',
                shape: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s10),
        Row(
          children: [
            Expanded(
              child: BuildWeatherDetailsItem(
                image: ImageAssets.uv,
                title: StringManager.uv,
                text: '${context.read<HomeCubit>().weatherModel!.current.uv.toInt()} of 10',
                shape: 2,
              ),
            ),
            const SizedBox(width: AppSize.s10),
            Expanded(
              child: BuildWeatherDetailsItem(
                image: ImageAssets.visibility,
                title: StringManager.visibility,
                text: '${context.read<HomeCubit>().weatherModel!.current.visKm.toInt()} ${ConstantsManager.kilometer}',
                shape: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSize.s10),
        Row(
          children: [
            Expanded(
              child: BuildWeatherDetailsItem(
                image: ImageAssets.moonPhase,
                title: StringManager.moonPhase,
                text: context.read<HomeCubit>().weatherModel!.forecast.forecastDay[0].astro.moonPhase,
                shape: 2,
              ),
            ),
            const SizedBox(width: AppSize.s10),
            Expanded(
              child: BuildWeatherDetailsItem(
                image: ImageAssets.moon,
                title: StringManager.moonIllumination,
                text: '${context.read<HomeCubit>().weatherModel!.forecast.forecastDay[0].astro.moonIllumination}${ConstantsManager.percentageSymbol}',
                shape: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}