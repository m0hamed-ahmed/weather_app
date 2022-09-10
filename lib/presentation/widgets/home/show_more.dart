import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/controller/home/states.dart';
import 'package:weather_app/presentation/controller/settings/cubit.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';

class ShowMore extends StatelessWidget {
  const ShowMore({Key? key}) : super(key: key);

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
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => context.read<HomeCubit>().changeShowMode(),
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.read<HomeCubit>().showMode == ShowMode.showLess ? StringManager.seeLess : StringManager.seeMore,
                            style: getMediumStyle(
                              color: isDark
                                  ? isFoundInTop ? ColorManager.white : ColorManager.white
                                  : isFoundInTop ? ColorManager.white : ColorManager.black,
                            ),
                          ),
                          const SizedBox(width: AppSize.s5),
                          Icon(
                            context.read<HomeCubit>().showMode == ShowMode.showLess ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            size: AppSize.s16,
                            color: isDark
                              ? isFoundInTop ? ColorManager.white : ColorManager.white
                              : isFoundInTop ? ColorManager.white : ColorManager.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s10),
              ],
            );
          },
        );
      },
    );
  }
}