import 'package:flutter/material.dart';
import 'package:weather_app/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(Color color, double fontSize, FontWeight fontWeight) {
  return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight, fontFamily: FontConstants.fontFamily);
}

TextStyle getBoldStyle({Color color = Colors.white, double fontSize = FontSize.s14}) {
  return _getTextStyle(color, fontSize, FontWeightManager.bold);
}

TextStyle getMediumStyle({Color color = Colors.white, double fontSize = FontSize.s14}) {
  return _getTextStyle(color, fontSize, FontWeightManager.medium);
}

TextStyle getRegularStyle({Color color = Colors.white, double fontSize = FontSize.s14}) {
  return _getTextStyle(color, fontSize, FontWeightManager.regular);
}

TextStyle getLightStyle({Color color = Colors.white, double fontSize = FontSize.s14}) {
  return _getTextStyle(color, fontSize, FontWeightManager.light);
}