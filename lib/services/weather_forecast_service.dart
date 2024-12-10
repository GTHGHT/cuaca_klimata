import 'package:flutter/material.dart';

import 'data_class/weather_forecast.dart';
import 'interface/weather_integration.dart';

class WeatherForecastService extends ChangeNotifier {
  WeatherForecast? weatherForecast;
  final WeatherIntegration? weatherIntegration;

  bool loading = true;

  WeatherForecastService(this.weatherIntegration) : loading = false;

  Future<void> updateWeatherForecast(double latitude, double longitude) async {
    WeatherIntegration? wi = weatherIntegration;
    if (wi != null && !loading) {
      if (weatherForecast?.latitude == latitude &&
          weatherForecast?.longitude == longitude) {
        return;
      }

      loading = true;
      notifyListeners();
      WeatherForecast result = await wi.getWeatherForecast(
        latitude,
        longitude,
      );
      weatherForecast = result;
      loading = false;
      notifyListeners();
    }
  }
}
