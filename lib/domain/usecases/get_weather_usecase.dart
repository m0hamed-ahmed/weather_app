import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/domain/repository/base_repository.dart';

class GetWeatherUsecase {
  BaseRepository baseRepository;

  GetWeatherUsecase(this.baseRepository);

  Future<Either<Failure, WeatherModel>> execute(String cityName) async {
    return await baseRepository.getWeather(cityName);
  }
}