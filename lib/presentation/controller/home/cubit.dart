import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/utils/cache_helper.dart';
import 'package:weather_app/core/utils/methods.dart';
import 'package:weather_app/data/data_source/remote_data_source.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repository/repository.dart';
import 'package:weather_app/domain/repository/base_repository.dart';
import 'package:weather_app/domain/usecases/get_weather_usecase.dart';
import 'package:weather_app/presentation/controller/home/states.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/enum.dart';
import 'package:weather_app/presentation/resources/font_manager.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  WeatherModel? weatherModel;

  Future<void> getWeather(String cityName) async {
    emit(HomeLoadingState());
    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    BaseRepository baseRepository = Repository(baseRemoteDataSource);
    GetWeatherUsecase getWeatherUsecase = GetWeatherUsecase(baseRepository);
    await getWeatherUsecase.execute(cityName).then((value) {
      value.fold((failure) {
        Methods.showToastMessage(failure.message, toastColor: ColorManager.red700);
        emit(HomeErrorState());
      }, (weatherModel) async {
        this.weatherModel = weatherModel;
        emit(HomeSuccessState());
      });
    });
  }

  ShowMode _showMode = ShowMode.showMore;
  ShowMode get showMode => _showMode;
  changeShowMode() {
    if(_showMode == ShowMode.showLess) {
      _showMode = ShowMode.showMore;
    }
    else {
      _showMode = ShowMode.showLess;
    }
    emit(ChangeShowMoreState());
  }

  double _fontSize = FontSize.s100;
  double get fontSize => _fontSize;
  changeFontSizeWhenScrolling(double fontSize) {
    _fontSize = fontSize;
    emit(ChangeFontSizeWhenScrollingState());
  }

  Future checkPermissionAndGetCurrentLocation(BuildContext context) async {
    if (await Geolocator.isLocationServiceEnabled()) {
      LocationPermission locationPermission = await Geolocator.checkPermission();

      if(locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if(locationPermission == LocationPermission.denied) {
          // ignore: use_build_context_synchronously
          await Methods.showAskDialog(context, StringManager.permission, StringManager.updateLocationPermission, isCancelOnly: true);
        }
        if(locationPermission == LocationPermission.deniedForever) {
          // ignore: use_build_context_synchronously
          await Methods.showAskDialog(context, StringManager.permission, StringManager.updateLocationPermission, isCancelOnly: true);
          emit(TryAgainState());
        }
        if(locationPermission == LocationPermission.whileInUse || locationPermission == LocationPermission.always) {
          await _getCurrentPosition();
        }
      }
      else if(locationPermission == LocationPermission.deniedForever) {
        // ignore: use_build_context_synchronously
        await Methods.showAskDialog(context, StringManager.permission, StringManager.updateLocationPermission, isCancelOnly: true);
        emit(TryAgainState());
      }
      else if(locationPermission == LocationPermission.whileInUse || locationPermission == LocationPermission.always) {
        await _getCurrentPosition();
      }
    }
    else {
      await Methods.showAskDialog(context, StringManager.location, StringManager.locationServicesAreDisabled, isCancelOnly: true);
      emit(TryAgainState());
    }
  }

  Future _getCurrentPosition() async {
    if(CacheHelper.getData(key: PREFERENCES_KEY_LOCATION) == null) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      String location = '${position.latitude},${position.longitude}';
      CacheHelper.setData(key: PREFERENCES_KEY_LOCATION, value: location);
      getWeather(location);
    }
    else {
      getWeather(CacheHelper.getData(key: PREFERENCES_KEY_LOCATION));
    }
  }

  bool _isFoundInTop = true;
  bool get isFoundInTop => _isFoundInTop;
  changeIsFoundInTop(bool isFoundInTop) {
    _isFoundInTop = isFoundInTop;
    emit(ChangeIsFoundInTopState());
  }

  bool onNotification(BuildContext context, ScrollNotification scrollNotification) {
    if(scrollNotification.metrics.pixels.toInt() > MediaQuery.of(context).size.height * 0.25) {
      if(_isFoundInTop == true) {
        changeIsFoundInTop(false);
        // changeFontSizeWhenScrolling(70);
      }
    }
    else {
      if(_isFoundInTop == false) {
        changeIsFoundInTop(true);
      }
      // for(int i=1; i<=20; i++) {
      //   if(scrollNotification.metrics.pixels.toInt() > 10 * i) {changeFontSizeWhenScrolling((110 - (i*2)).toDouble());}
      // }
    }
    return false;
  }
}