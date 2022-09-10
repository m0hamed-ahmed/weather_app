import 'package:equatable/equatable.dart';
import 'package:weather_app/data/models/air_quality_model.dart';
import 'package:weather_app/data/models/condition_model.dart';

class CurrentModel extends Equatable {
  final double tempC;
  final double tempF;
  final ConditionModel condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final int humidity;
  final int cloud;
  final double feelsLikeC;
  final double feelsLikeF;
  final double visKm;
  final double visMiles;
  final double uv;
  final AirQualityModel airQuality;

  const CurrentModel({
    required this.tempC,
    required this.tempF,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.humidity,
    required this.cloud,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.airQuality,
  });

  factory CurrentModel.fromJson(Map<String, dynamic> json) {
    return CurrentModel(
      tempC: json["temp_c"],
      tempF: json["temp_f"],
      condition: ConditionModel.fromJson(json["condition"]),
      windMph: json["wind_mph"],
      windKph: json["wind_kph"],
      windDegree: json["wind_degree"],
      windDir: json["wind_dir"],
      pressureMb: json["pressure_mb"],
      pressureIn: json["pressure_in"],
      humidity: json["humidity"],
      cloud: json["cloud"],
      feelsLikeC: json["feelslike_c"],
      feelsLikeF: json["feelslike_f"],
      visKm: json["vis_km"],
      visMiles: json["vis_miles"],
      uv: json["uv"],
      airQuality: AirQualityModel.fromJson(json["air_quality"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "temp_c": tempC,
      "temp_f": tempF,
      "condition": condition,
      "wind_mph": windMph,
      "wind_kph": windKph,
      "wind_degree": windDegree,
      "wind_dir": windDir,
      "pressure_mb": pressureMb,
      "pressure_in": pressureIn,
      "humidity": humidity,
      "cloud": cloud,
      "feelslike_c": feelsLikeC,
      "feelslike_f": feelsLikeF,
      "vis_km": visKm,
      "vis_miles": visMiles,
      "uv": uv,
      "air_quality": airQuality,
    };
  }

  @override
  List<Object?> get props => [
    tempC,
    tempF,
    condition,
    windMph,
    windKph,
    windDegree,
    windDir,
    pressureMb,
    pressureIn,
    humidity,
    cloud,
    feelsLikeC,
    feelsLikeF,
    visMiles,
    visKm,
    uv,
    airQuality,
  ];
}