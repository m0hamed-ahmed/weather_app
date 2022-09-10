import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/app.dart';
import 'package:weather_app/core/utils/bloc_observer.dart';
import 'package:weather_app/core/utils/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  runApp(const MyApp());
  //BlocOverrides.runZoned(() => runApp(const MyApp()), blocObserver: MyBlocObserver());
}