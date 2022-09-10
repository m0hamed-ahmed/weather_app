class ApiConstance {
  static const String baseUrl = 'https://api.weatherapi.com/v1';
  static const String apiKey = '091d112f025d40cf8e1113353220509';
  static const String weatherPath = '$baseUrl/forecast.json?key=$apiKey&days=14&aqi=yes';
}