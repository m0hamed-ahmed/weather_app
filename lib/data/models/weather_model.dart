import 'package:equatable/equatable.dart';
import 'package:weather_app/data/models/current_model.dart';
import 'package:weather_app/data/models/forecast_model.dart';
import 'package:weather_app/data/models/location_model.dart';

class WeatherModel extends Equatable {
  final LocationModel location;
  final CurrentModel current;
  final ForecastModel forecast;

  const WeatherModel({required this.location, required this.current, required this.forecast});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: LocationModel.fromJson(json["location"]),
      current: CurrentModel.fromJson(json["current"]),
      forecast: ForecastModel.fromJson(json["forecast"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "location": location,
      "current": current,
      "forecast": forecast,
    };
  }

  @override
  List<Object?> get props => [location, current, forecast];
}