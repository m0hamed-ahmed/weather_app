import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/controller/favorite_locations/states.dart';

class FavoriteLocationsCubit extends Cubit<FavoriteLocationsStates> {
  FavoriteLocationsCubit() : super(FavoriteLocationsInitialState());

  static FavoriteLocationsCubit get(context) => BlocProvider.of(context);

  final List<String> _favoriteLocations = [];
  List<String> get favoriteLocations => _favoriteLocations;
  addToFavoriteLocations(String location) {
    _favoriteLocations.add(location);
    emit(ChangeFavoriteLocationsState());
  }
  removeFromFavoriteLocations(String location) {
    _favoriteLocations.removeWhere((element) => element == location);
    emit(ChangeFavoriteLocationsState());
  }

  String _selectedLocation = '';
  String get selectedLocation => _selectedLocation;
  changeSelectedLocation(String selectedLocation) {
    _selectedLocation = selectedLocation;
    emit(ChangeSelectedLocationState());
  }
}