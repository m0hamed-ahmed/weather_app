import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:weather_app/data/models/astro_model.dart';
import 'package:weather_app/data/models/day_model.dart';
import 'package:weather_app/data/models/hour_model.dart';

class ForecastDayModel extends Equatable {
  final String date;
  final DayModel day;
  final AstroModel astro;
  final List<HourModel> hour;

  const ForecastDayModel({
    required this.date,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    return ForecastDayModel(
      date: json["date"],
      day: DayModel.fromJson(json["day"]),
      astro: AstroModel.fromJson(json["astro"]),
      hour: List<HourModel>.from(List.from(json['hour']).map((i) => HourModel.fromJson(i))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "day": day,
      "astro": astro,
      "hour": jsonEncode(hour),
    };
  }

  @override
  List<Object?> get props => [date, day, astro, hour];
}