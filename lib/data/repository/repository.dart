import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/data/data_source/remote_data_source.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/domain/repository/base_repository.dart';

class Repository extends BaseRepository {
  final BaseRemoteDataSource baseRemoteDataSource;

  Repository(this.baseRemoteDataSource);

  @override
  Future<Either<Failure, WeatherModel>> getWeather(String cityName) async {
    try {
      WeatherModel weatherModel = await baseRemoteDataSource.getWeather(cityName);
      return Right(weatherModel);
    } catch(e) {
      return Left(Failure(e.toString()));
    }
  }
}