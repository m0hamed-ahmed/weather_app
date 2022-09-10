import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/controller/favorite_locations/cubit.dart';
import 'package:weather_app/presentation/controller/favorite_locations/states.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/controller/home/states.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/font_manager.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/widgets/favorite_locations/favorite_location_item.dart';

class FavoriteLocationsScreen extends StatelessWidget {
  const FavoriteLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsStates, ChangeAppearanceState>(
      selector: (state) => ChangeAppearanceState(),
      builder: (context, _) {
        bool isDark = SettingsCubit.get(context).appearance == Appearance.dark;

        return BlocSelector<HomeCubit, HomeStates, ChangeIsFoundInTopState>(
          selector: (state) => ChangeIsFoundInTopState(),
          builder: (context, _) {
            bool isFoundInTop = HomeCubit.get(context).isFoundInTop;

            return BlocBuilder<FavoriteLocationsCubit, FavoriteLocationsStates>(
              builder: (context, _) {
                FavoriteLocationsCubit favoriteLocationsCubit = FavoriteLocationsCubit.get(context);

                return Scaffold(
                  backgroundColor: isDark ? ColorManager.darkPrimaryColor : ColorManager.lightPrimaryColor,
                  appBar: AppBar(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: isDark ? ColorManager.darkPrimaryColor : ColorManager.lightPrimaryColor,
                      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
                    ),
                    backgroundColor: isDark ? ColorManager.darkPrimaryColor : ColorManager.lightPrimaryColor,
                    iconTheme: IconThemeData(color: isDark ? ColorManager.white : ColorManager.black),
                    title: Text(StringManager.favoriteLocations, style: getBoldStyle(color: isDark ? ColorManager.white : ColorManager.black, fontSize: FontSize.s22)),
                  ),
                  body: ListView.builder(
                    itemBuilder: (context, index) => FavoriteLocationItem(location: favoriteLocationsCubit.favoriteLocations[index]),
                    itemCount: favoriteLocationsCubit.favoriteLocations.length,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}