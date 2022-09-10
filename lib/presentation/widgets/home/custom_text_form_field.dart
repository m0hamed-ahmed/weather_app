import 'package:flutter/material.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final bool enabled;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final int maxLines;
  final String hint;
  final Color fillColor;
  final Color borderColor;
  final double borderRadius;
  IconData? prefixIcon;
  Color prefixIconColor;
  final Widget? suffix;
  Function(String)? onFieldSubmitted;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  final bool isValidatorRequired;

  CustomTextFormField({
    Key? key,
    this.enabled = true,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.maxLines = 1,
    this.hint = '',
    this.fillColor = Colors.white,
    this.borderColor = Colors.white,
    this.borderRadius = 10.0,
    this.prefixIcon,
    this.prefixIconColor = Colors.white,
    this.suffix,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
    this.isValidatorRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        TextFormField(
          enabled: enabled,
          controller: controller,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          cursorColor: ColorManager.white,
          validator: isValidatorRequired ? (val) {
            if(val!.trim().isEmpty) {return StringManager.required;}
            return null;
          } : validator,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          style: getMediumStyle(color: ColorManager.white).copyWith(fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.all(AppPadding.p20),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: prefixIconColor) : null,
            hintText: hint,
            hintStyle: getMediumStyle(color: ColorManager.white),
            errorStyle: getMediumStyle(color: ColorManager.red700),
            border: OutlineInputBorder(borderSide: BorderSide(color: borderColor), borderRadius: BorderRadius.circular(borderRadius)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor), borderRadius: BorderRadius.circular(borderRadius)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor), borderRadius: BorderRadius.circular(borderRadius)),
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.red700), borderRadius: BorderRadius.circular(borderRadius)),
            focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.red700), borderRadius: BorderRadius.circular(borderRadius)),
          ),
        ),
        if(suffix != null) suffix!,
      ],
    );
  }
}