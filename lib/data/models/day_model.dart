import 'package:equatable/equatable.dart';
import 'package:weather_app/data/models/air_quality_model.dart';
import 'package:weather_app/data/models/condition_model.dart';

class DayModel extends Equatable {
  final double maxTempC;
  final double minTempC;
  final double maxTempF;
  final double minTempF;
  final double maxWindMph;
  final double maxWindKph;
  final double totalPrecipitationMm;
  final double totalPrecipitationIn;
  final int dailyWillItRain;
  final int dailyChanceOfRain;
  final int dailyWillItSnow;
  final int dailyChanceOfSnow;
  final ConditionModel condition;
  final double uv;
  final AirQualityModel airQuality;
  
  const DayModel({
    required this.maxTempC,
    required this.minTempC,
    required this.maxTempF,
    required this.minTempF,
    required this.maxWindMph,
    required this.maxWindKph,
    required this.totalPrecipitationMm,
    required this.totalPrecipitationIn,
    required this.dailyWillItRain,
    required this.dailyChanceOfRain,
    required this.dailyWillItSnow,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
    required this.airQuality,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      maxTempC: json["maxtemp_c"],
      minTempC: json["mintemp_c"],
      maxTempF: json["maxtemp_f"],
      minTempF: json["mintemp_f"],
      maxWindMph: json["maxwind_mph"],
      maxWindKph: json["maxwind_kph"],
      totalPrecipitationMm: json["totalprecip_mm"],
      totalPrecipitationIn: json["totalprecip_in"],
      dailyWillItRain: json["daily_will_it_rain"],
      dailyChanceOfRain: json["daily_chance_of_rain"],
      dailyWillItSnow: json["daily_will_it_snow"],
      dailyChanceOfSnow: json["daily_chance_of_snow"],
      condition: ConditionModel.fromJson(json["condition"]),
      uv: json["uv"],
      airQuality: AirQualityModel.fromJson(json["air_quality"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "maxtemp_c": maxTempC,
      "mintemp_c": minTempC,
      "maxtemp_f": maxTempF,
      "mintemp_f": minTempF,
      "maxwind_mph": maxWindMph,
      "maxwind_kph": maxWindKph,
      "totalprecip_mm": totalPrecipitationMm,
      "totalprecip_in": totalPrecipitationIn,
      "daily_will_it_rain": dailyWillItRain,
      "daily_chance_of_rain": dailyChanceOfRain,
      "daily_will_it_snow": dailyWillItSnow,
      "daily_chance_of_snow": dailyChanceOfSnow,
      "condition": condition,
      "uv": uv,
      "airQuality": airQuality,
    };
  }

  @override
  List<Object?> get props => [
    maxTempC,
    minTempC,
    maxTempF,
    minTempF,
    maxWindMph,
    maxWindKph,
    totalPrecipitationMm,
    totalPrecipitationIn,
    dailyWillItRain,
    dailyChanceOfRain,
    dailyWillItSnow,
    dailyChanceOfSnow,
    condition,
    uv,
    airQuality,
  ];
}