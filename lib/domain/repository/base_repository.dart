import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/data/models/weather_model.dart';

abstract class BaseRepository {
  Future<Either<Failure, WeatherModel>> getWeather(String cityName);
}