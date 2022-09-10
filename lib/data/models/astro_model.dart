import 'package:equatable/equatable.dart';

class AstroModel extends Equatable {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;
  final String moonPhase;
  final String moonIllumination;

  const AstroModel({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.moonIllumination,
  });


  factory AstroModel.fromJson(Map<String, dynamic> json) {
    return AstroModel(
      sunrise: json["sunrise"],
      sunset: json["sunset"],
      moonrise: json["moonrise"],
      moonset: json["moonset"],
      moonPhase: json["moon_phase"],
      moonIllumination: json["moon_illumination"],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "sunrise": sunrise,
      "sunset": sunset,
      "moonrise": moonrise,
      "moonset": moonset,
      "moon_phase": moonPhase,
      "moon_illumination": moonIllumination,
    };
  }

  @override
  List<Object?> get props => [
    sunrise,
    sunset,
    moonrise,
    moonset,
    moonPhase,
    moonIllumination,
  ];
}