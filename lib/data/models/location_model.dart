import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String name;
  final String localtime;

  const LocationModel({
    required this.name,
    required this.localtime,
  });

  @override
  List<Object?> get props => [name, localtime];

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json["name"],
      localtime: json["localtime"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "localtime": localtime,
    };
  }
}