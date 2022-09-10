import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/controller/favorite_locations/cubit.dart';
import 'package:weather_app/presentation/controller/favorite_locations/states.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/font_manager.dart';
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';

class FavoriteLocationItem extends StatelessWidget {
  final String location;

  const FavoriteLocationItem({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsStates, ChangeAppearanceState>(
      selector: (state) => ChangeAppearanceState(),
      builder: (context, _) {
        bool isDark = SettingsCubit.get(context).appearance == Appearance.dark;

        return BlocSelector<FavoriteLocationsCubit, FavoriteLocationsStates, ChangeFavoriteLocationsState>(
          selector: (state) => ChangeFavoriteLocationsState(),
          builder: (context, _) {
            FavoriteLocationsCubit favoriteLocationsCubit = FavoriteLocationsCubit.get(context);

            return InkWell(
              onTap: () {
                favoriteLocationsCubit.changeSelectedLocation(location);
                context.read<HomeCubit>().getWeather(location);
              },
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      location,
                      style: getMediumStyle(
                        fontSize: FontSize.s18,
                        color: isDark ? ColorManager.white : ColorManager.black,
                      ),
                    ),
                    Row(
                      children: [
                        if(favoriteLocationsCubit.selectedLocation == location) Icon(Icons.check, color: isDark ? ColorManager.white : ColorManager.black),
                        const SizedBox(width: AppSize.s10),
                        IconButton(
                          onPressed: () => context.read<FavoriteLocationsCubit>().removeFromFavoriteLocations(location),
                          icon: Icon(Icons.favorite, color: isDark ? ColorManager.white : ColorManager.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}