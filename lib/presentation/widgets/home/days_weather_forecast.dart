import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app/data/models/forecast_day_model.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/controller/home/states.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';
import 'package:weather_app/presentation/widgets/home/build_title.dart';
import 'package:weather_app/presentation/widgets/home/day_item.dart';

// ignore: must_be_immutable
class DaysWeatherForecast extends StatelessWidget {
  List<DayChart> daysChart = [];

  DaysWeatherForecast({Key? key}) : super(key: key);

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

            List<ForecastDayModel> list = context.read<HomeCubit>().weatherModel!.forecast.forecastDay;
            daysChart = [];
            for(int i=0; i<list.length; i++) {
              daysChart.add(DayChart(list[i].date, list[i].day.maxTempC));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BuildTitle(title: StringManager.daysWeatherForecast),
                Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? isFoundInTop ? ColorManager.defaultSecondaryColor : ColorManager.darkSecondaryColor
                        : isFoundInTop ? ColorManager.defaultSecondaryColor : ColorManager.lightSecondaryColor,
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(AppSize.s15), bottomLeft: Radius.circular(AppSize.s15), topRight: Radius.circular(AppSize.s15)),
                  ),
                  child: BlocSelector<HomeCubit, HomeStates, ChangeShowMoreState>(
                    selector: (state) => ChangeShowMoreState(),
                    builder: (context, state) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(AppPadding.p15),
                        itemBuilder: (context, index) => DayItem(forecastDayModel: context.read<HomeCubit>().weatherModel!.forecast.forecastDay[index]),
                        separatorBuilder: (context, index) => const SizedBox(height: AppSize.s5),
                        itemCount: context.read<HomeCubit>().showMode == ShowMode.showLess ? context.read<HomeCubit>().weatherModel!.forecast.forecastDay.length : 3,
                      );
                    },
                  ),
                ),
                if(context.read<HomeCubit>().showMode == ShowMode.showLess) Column(
                  children: [
                    const SizedBox(height: AppSize.s10),
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <LineSeries<DayChart, String>> [
                        LineSeries<DayChart, String>(
                          dataSource:  daysChart,
                          xValueMapper: (DayChart data, _) => data.date,
                          yValueMapper: (DayChart data, _) => data.temp,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.s5),
              ],
            );
          },
        );
      },
    );
  }
}

class DayChart {

  DayChart(this.date, this.temp);

  final String date;
  final double temp;
}
