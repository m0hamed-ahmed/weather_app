import 'package:equatable/equatable.dart';

class ConditionModel extends Equatable {
  final String text;
  final String icon;

  const ConditionModel({required this.text, required this.icon});

  factory ConditionModel.fromJson(Map<String, dynamic> json) {
    return ConditionModel(
      text: json["text"],
      icon: json["icon"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "icon": icon,
    };
  }

  @override
  List<Object?> get props => [text, icon];
}