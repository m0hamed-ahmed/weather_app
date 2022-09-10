import 'package:flutter/material.dart';
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
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key? key}) : super(key: key);

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
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              context.read<HomeCubit>().weatherModel!.location.name,
                              style: getBoldStyle(
                                  color: isDark
                                      ? isFoundInTop ? ColorManager.white : ColorManager.white
                                      : isFoundInTop ? ColorManager.white : ColorManager.black,
                                  fontSize: FontSize.s20
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSize.s5),
                          Icon(
                            Icons.location_on,
                            size: AppSize.s16,
                            color: isDark
                                ? isFoundInTop ? ColorManager.white : ColorManager.white
                                : isFoundInTop ? ColorManager.white : ColorManager.black,
                          ),
                        ],
                      ),
                    ),
                    BlocSelector<FavoriteLocationsCubit, FavoriteLocationsStates, ChangeFavoriteLocationsState>(
                      selector: (state) => ChangeFavoriteLocationsState(),
                      builder: (context, _) {
                        FavoriteLocationsCubit favoriteLocationsCubit = FavoriteLocationsCubit.get(context);
                        bool locationIsFoundInFavorite = favoriteLocationsCubit.favoriteLocations.indexWhere((element) => element == context.read<HomeCubit>().weatherModel!.location.name.toLowerCase()) != -1;

                        return IconButton(
                          onPressed: () {
                            if(locationIsFoundInFavorite) {
                              context.read<FavoriteLocationsCubit>().removeFromFavoriteLocations(context.read<HomeCubit>().weatherModel!.location.name.toLowerCase());
                            }
                            else {
                              context.read<FavoriteLocationsCubit>().addToFavoriteLocations(context.read<HomeCubit>().weatherModel!.location.name.toLowerCase());
                            }
                          },
                          icon: Icon(locationIsFoundInFavorite ? Icons.favorite : Icons.favorite_border, color: ColorManager.white),
                        );
                      }
                    ),
                  ],
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
