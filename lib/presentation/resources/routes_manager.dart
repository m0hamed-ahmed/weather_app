import 'package:flutter/material.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/screens/favorite_locations/favorite_locations_screen.dart';
import 'package:weather_app/presentation/screens/home/home_screen.dart';
import 'package:weather_app/presentation/screens/settings/settings_screen.dart';
import 'package:weather_app/presentation/screens/splash/splash_screen.dart';

class Routes {
  static const String splashRoute = '/';
  static const String homeRoute = '/homeRoute';
  static const String settingsRoute = '/settingsRoute';
  static const String favoriteLocationsRoute = '/favoriteLocationsRoute';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch(routeSettings.name) {
      case Routes.splashRoute: return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.homeRoute: return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.settingsRoute: return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case Routes.favoriteLocationsRoute: return MaterialPageRoute(builder: (_) => const FavoriteLocationsScreen());
      default: return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.noRouteFound)
        ),
        body: const Center(
          child: Text(StringManager.noRouteFound)
        ),
      )
    );
  }
}