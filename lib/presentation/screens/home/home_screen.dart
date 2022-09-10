import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/methods.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/controller/home/states.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/font_manager.dart';
import 'package:weather_app/presentation/resources/routes_manager.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';
import 'package:weather_app/presentation/widgets/home/air_quality.dart';
import 'package:weather_app/presentation/widgets/home/current_temp.dart';
import 'package:weather_app/presentation/widgets/home/custom_button.dart';
import 'package:weather_app/presentation/widgets/home/days_weather_forecast.dart';
import 'package:weather_app/presentation/widgets/home/hourly_forecast.dart';
import 'package:weather_app/presentation/widgets/home/image_widget.dart';
import 'package:weather_app/presentation/widgets/home/location_widget.dart';
import 'package:weather_app/presentation/widgets/home/max_min_temp.dart';
import 'package:weather_app/presentation/widgets/home/search_widget.dart';
import 'package:weather_app/presentation/widgets/home/show_more.dart';
import 'package:weather_app/presentation/widgets/home/tomorrow_weather_forecast.dart';
import 'package:weather_app/presentation/widgets/home/weather_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingControllerSearch = TextEditingController();

  @override
  void initState() {
    context.read<HomeCubit>().checkPermissionAndGetCurrentLocation(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Methods.showAskDialog(context, StringManager.areYouSure, StringManager.exitApp, isYesOrNo: true),
      child: BlocBuilder<HomeCubit, HomeStates>(
        buildWhen: (previous, current) {
          if(current is ChangeShowMoreState) {return false;}
          if(current is ChangeFontSizeWhenScrollingState) {return false;}
          if(current is ChangeIsFoundInTopState) {return false;}
          return true;
        },
        builder: (context, state) {
          return BlocSelector<SettingsCubit, SettingsStates, ChangeAppearanceState>(
            selector: (state) => ChangeAppearanceState(),
            builder: (context, _) {
              bool isDark = SettingsCubit.get(context).appearance == Appearance.dark;

              return BlocSelector<HomeCubit, HomeStates, ChangeIsFoundInTopState>(
                selector: (state) => ChangeIsFoundInTopState(),
                builder: (context, _) {
                  bool isFoundInTop = HomeCubit.get(context).isFoundInTop;

                  return Scaffold(
                    backgroundColor: isDark
                        ? isFoundInTop ? ColorManager.defaultPrimaryColor : ColorManager.darkPrimaryColor
                        : isFoundInTop ? ColorManager.defaultPrimaryColor : ColorManager.lightPrimaryColor,
                    appBar: AppBar(
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: isDark
                            ? isFoundInTop ? ColorManager.defaultPrimaryColor : ColorManager.darkPrimaryColor
                            : isFoundInTop ? ColorManager.defaultPrimaryColor : ColorManager.lightPrimaryColor,
                        statusBarIconBrightness: isDark
                            ? Brightness.light
                            : isFoundInTop ?  Brightness.light : Brightness.dark,
                      ),
                      backgroundColor: isDark
                          ? isFoundInTop ? ColorManager.defaultPrimaryColor : ColorManager.darkPrimaryColor
                          : isFoundInTop ? ColorManager.defaultPrimaryColor : ColorManager.lightPrimaryColor,
                      title: Text(
                        context.read<HomeCubit>().weatherModel == null ? StringManager.appName : context.read<HomeCubit>().weatherModel!.location.name,
                        style: getBoldStyle(
                          color: isDark
                              ? ColorManager.white
                              : isFoundInTop ? ColorManager.white : ColorManager.black,
                          fontSize: FontSize.s22,
                        ),
                      ),
                      actions: [
                        if(context.read<HomeCubit>().weatherModel != null) IconButton(
                          onPressed: () => Navigator.pushNamed(context, Routes.settingsRoute),
                          icon: Icon(
                            Icons.settings,
                            color: isDark
                                ? ColorManager.white
                                : isFoundInTop ? ColorManager.white : ColorManager.black,
                          ),
                        ),
                      ],
                    ),
                    body: buildBody(state),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget buildBody(HomeStates state) {
    if(state is HomeLoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    else if(state is TryAgainState) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onPressed: () => context.read<HomeCubit>().checkPermissionAndGetCurrentLocation(context),
              width: AppSize.s100,
              icon: Icons.refresh,
              text: '${StringManager.tryAgain} ',
            ),
          ],
        ),
      );
    }
    else {
      if(context.read<HomeCubit>().weatherModel == null) {
        return Container();
      }
      else {
        return Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: RefreshIndicator(
            color: ColorManager.defaultPrimaryColor,
            onRefresh: () async => await context.read<HomeCubit>().checkPermissionAndGetCurrentLocation(context),
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) => context.read<HomeCubit>().onNotification(context, scrollNotification),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        const ImageWidget(),
                        SearchWidget(textEditingController: textEditingControllerSearch),
                      ],
                    ),
                    const CurrentTemp(),
                    const LocationWidget(),
                    const MaxMinTemp(),
                    const HourlyForecast(),
                    const TomorrowWeatherForecast(),
                    DaysWeatherForecast(),
                    const ShowMore(),
                    const AirQuality(),
                    const WeatherDetails(),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    textEditingControllerSearch.dispose();
    super.dispose();
  }
}