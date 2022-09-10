enum ShowMode {showLess, showMore}

enum TemperatureUnit {c, f}

enum Appearance {light, dark}

TemperatureUnit convertStringToTemperatureUnit(String? temperatureUnit) {
  switch (temperatureUnit) {
    case 'f': return TemperatureUnit.f;
    default: return TemperatureUnit.c;
  }
}

Appearance convertStringToAppearance(String? appearance) {
    switch(appearance) {
      case 'light': return Appearance.light;
      default: return Appearance.dark;
    }
}