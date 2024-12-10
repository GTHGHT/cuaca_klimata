import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import '../services/location.dart';
import 'data_class/weather_code.dart';
import 'data_class/weather.dart';
import 'interface/weather_integration.dart';

class WeatherService extends ChangeNotifier {
  Weather? currentWeather;
  WeatherIntegration? weatherIntegration;

  bool loading = true;

  WeatherService(this.weatherIntegration) : loading = true;

  Future<WeatherCode> updateCurrentLocationWeather() async {
    WeatherIntegration? wi = weatherIntegration;
    if(wi == null){
      await Future.delayed(Duration(seconds: 3));
      wi = weatherIntegration;
    }
    debugPrint("Current Location");
    if (wi != null) {
    debugPrint("Weather Integration After If");
      loading = true;
      notifyListeners();
      Position position = await Location.getLocation();
      if (position.latitude == currentWeather?.latitude &&
          position.longitude == currentWeather?.longitude) {
        loading = false;
        notifyListeners();
        return currentWeather?.weatherCode ?? WeatherCode.none;
      }

      Weather weather =
          await wi.getLocationWeather(position.latitude, position.longitude);

      currentWeather = weather;
      loading = false;
      notifyListeners();
      return weather.weatherCode;
    }
    return WeatherCode.none;
  }

  Future<WeatherCode> updateCityWeather(String city) async {
    WeatherIntegration? wi = weatherIntegration;
    if (wi != null) {
      if (city.isEmpty) {
        return WeatherCode.none;
      }
      loading = true;
      notifyListeners();
      city = city.trim().replaceAll(" ", "%20");
      Weather cityWeather = await wi.getCityWeather(city);
      currentWeather = cityWeather;
      loading = false;
      notifyListeners();
      return cityWeather.weatherCode;
    }
    return WeatherCode.none;
  }
}
