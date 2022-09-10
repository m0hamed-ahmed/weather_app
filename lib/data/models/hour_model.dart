import 'package:equatable/equatable.dart';
import 'package:weather_app/data/models/air_quality_model.dart';
import 'package:weather_app/data/models/condition_model.dart';

class HourModel extends Equatable {
  final String time;
  final double tempC;
  final double tempF;
  final ConditionModel condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final int humidity;
  final int cloud;
  final double windchillC;
  final double windchillF;
  final int willItRain;
  final int chanceOfRain;
  final int willItSnow;
  final int chanceOfSnow;
  final double gustMph;
  final double gustKph;
  final double uv;
  final AirQualityModel airQuality;

  const HourModel({
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.humidity,
    required this.cloud,
    required this.windchillC,
    required this.windchillF,
    required this.willItRain,
    required this.chanceOfRain,
    required this.willItSnow,
    required this.chanceOfSnow,
    required this.gustMph,
    required this.gustKph,
    required this.uv,
    required this.airQuality
  });

  factory HourModel.fromJson(Map<String, dynamic> json) {
    return HourModel(
      time: json["time"],
      tempC: json["temp_c"],
      tempF: json["temp_f"],
      condition: ConditionModel.fromJson(json["condition"]),
      windMph: json["wind_mph"],
      windKph: json["wind_kph"],
      windDegree: json["wind_degree"],
      windDir: json["wind_dir"],
      humidity: json["humidity"],
      cloud: json["cloud"],
      windchillC: json["windchill_c"],
      windchillF: json["windchill_f"],
      willItRain: json["will_it_rain"],
      chanceOfRain: json["chance_of_rain"],
      willItSnow: json["will_it_snow"],
      chanceOfSnow: json["chance_of_snow"],
      gustMph: json["gust_mph"],
      gustKph: json["gust_kph"],
      uv: json["uv"],
      airQuality: AirQualityModel.fromJson(json["air_quality"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "time": time,
      "temp_c": tempC,
      "temp_f": tempF,
      "condition": condition,
      "wind_mph": windMph,
      "wind_kph": windKph,
      "wind_degree": windDegree,
      "wind_dir": windDir,
      "humidity": humidity,
      "cloud": cloud,
      "windchill_c": windchillC,
      "windchill_f": windchillF,
      "will_it_rain": willItRain,
      "chance_of_rain": chanceOfRain,
      "will_it_snow": willItSnow,
      "chance_of_snow": chanceOfSnow,
      "gust_mph": gustMph,
      "gust_kph": gustKph,
      "uv": uv,
      "air_quality": airQuality,
    };
  }

  @override
  List<Object?> get props => [
    time,
    tempC,
    tempF,
    condition,
    windMph,
    windKph,
    windDegree,
    windDir,
    humidity,
    cloud,
    windchillC,
    windchillF,
    willItRain,
    chanceOfRain,
    willItSnow,
    chanceOfSnow,
    gustMph,
    gustKph,
    uv,
    airQuality,
  ];
}