import 'dart:convert';
import 'package:weather_app/core/network/api_constance.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class BaseRemoteDataSource {
  Future<WeatherModel> getWeather(String cityName);
}

class RemoteDataSource extends BaseRemoteDataSource{

  @override
  Future<WeatherModel> getWeather(String cityName) async {
    http.Response response = await http.get(Uri.parse('${ApiConstance.weatherPath}&q=$cityName'));
    if(response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw(response.reasonPhrase ?? 'An error occurred');
    }
  }
}