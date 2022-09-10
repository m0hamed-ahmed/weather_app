import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/models/forecast_day_model.dart';

class ForecastModel extends Equatable {
  final List<ForecastDayModel> forecastDay;

  const ForecastModel({required this.forecastDay});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      forecastDay: List<ForecastDayModel>.from(List.from(json['forecastday']).map((i) => ForecastDayModel.fromJson(i))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "forecastday": jsonEncode(forecastDay),
    };
  }

  @override
  List<Object?> get props => [forecastDay];
}