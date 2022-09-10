import 'package:flutter/material.dart';
import 'package:weather_app/presentation/resources/styles_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final String? image;
  final IconData? icon;
  final Color iconColor;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final double width;
  final double height;
  final double elevation;
  final double radius;

  const CustomButton({
    Key? key,
    required this.onPressed,
    this.text,
    this.image,
    this.icon,
    this.iconColor = Colors.white,
    this.buttonColor = const Color(0xff62648b),
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.width = double.infinity,
    this.height = AppSize.s45,
    this.elevation = AppSize.s0,
    this.radius = AppSize.s10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      minWidth: width,
      height: height,
      color: buttonColor,
      elevation: elevation,
      hoverElevation: elevation,
      focusElevation: elevation,
      highlightElevation: elevation,
      shape: RoundedRectangleBorder(side: BorderSide(color: borderColor, width: AppSize.s2), borderRadius: BorderRadius.circular(radius)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(text != null) Text(text!, style: getBoldStyle(color: textColor)),
          if(image != null) Image.asset(image!, width: AppSize.s20, height: AppSize.s20),
          if(icon != null) Icon(icon, color: iconColor, size: AppSize.s16),
        ],
      ),
    );
  }
}