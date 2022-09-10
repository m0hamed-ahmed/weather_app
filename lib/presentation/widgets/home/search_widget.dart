import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/controller/home/cubit.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';
import 'package:weather_app/presentation/widgets/home/custom_text_form_field.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController textEditingController;

  const SearchWidget({Key? key, required this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: textEditingController,
          fillColor: Colors.transparent,
          hint: StringManager.typeCityNameHere,
          prefixIcon: Icons.search,
          suffix: IconButton(
            onPressed: () => context.read<HomeCubit>().getWeather(textEditingController.text.trim()),
            icon: Icon(Icons.arrow_forward, color: ColorManager.white),
          ),
        ),
        const SizedBox(height: AppSize.s10),
      ],
    );
  }
}