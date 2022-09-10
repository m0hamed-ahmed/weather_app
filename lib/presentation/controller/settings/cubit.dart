import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/utils/cache_helper.dart';
import 'package:weather_app/presentation/controller/settings/states.dart';
import 'package:weather_app/presentation/resources/enum.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  TemperatureUnit _temperatureUnit = TemperatureUnit.c;
  TemperatureUnit get temperatureUnit => _temperatureUnit;
  setTemperatureUnit(TemperatureUnit temperatureUnit) => _temperatureUnit = temperatureUnit;
  changeTemperatureUnit() {
    if(_temperatureUnit == TemperatureUnit.c) {
      _temperatureUnit = TemperatureUnit.f;
    }
    else {
      _temperatureUnit = TemperatureUnit.c;
    }
    CacheHelper.setData(key: PREFERENCES_KEY_TEMPERATUREUNIT, value: _temperatureUnit.name);
    emit(ChangeTemperatureUnitState());
  }

  Appearance _appearance = Appearance.dark;
  Appearance get appearance => _appearance;
  setAppearance(Appearance appearance) => _appearance = appearance;
  changeAppearance() {
    if(_appearance == Appearance.dark) {
      _appearance = Appearance.light;
    }
    else {
      _appearance = Appearance.dark;
    }
    CacheHelper.setData(key: PREFERENCES_KEY_APPEARANCE, value: _appearance.name);
    emit(ChangeAppearanceState());
  }
}