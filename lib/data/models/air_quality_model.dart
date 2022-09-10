import 'package:equatable/equatable.dart';

class AirQualityModel extends Equatable {
  final double co;
  final double no2;
  final double o3;
  final double so2;

  const AirQualityModel({
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
  });

  factory AirQualityModel.fromJson(Map<String, dynamic> json) {
    return AirQualityModel(
      co: json["co"].runtimeType == Null ? 0.0 : json["co"].runtimeType == String ? double.parse(json["co"]) : json["co"],
      no2: json["no2"].runtimeType == Null ? 0.0 : json["no2"].runtimeType == String ? double.parse(json["no2"]) : json["no2"],
      o3: json["o3"].runtimeType == Null ? 0.0 : json["o3"].runtimeType == String ? double.parse(json["o3"]) : json["o3"],
      so2: json["so2"].runtimeType == Null ? 0.0 : json["so2"].runtimeType == String ? double.parse(json["so2"]) : json["so2"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "co": co,
      "no2": no2,
      "o3": o3,
      "so2": so2,
    };
  }

  @override
  List<Object?> get props => [co, no2, o3, so2];
}