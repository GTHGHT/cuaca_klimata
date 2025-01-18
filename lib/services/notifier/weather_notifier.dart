import 'package:cuaca_klimata/services/data_class/geo_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import '../location.dart';
import '../data_class/weather_code.dart';
import '../data_class/weather.dart';
import '../interface/weather_integration.dart';

class WeatherNotifier extends ChangeNotifier {
  Weather? currentWeather;
  WeatherIntegration? weatherIntegration;

  bool loading;

  WeatherNotifier(this.weatherIntegration) : loading = true;

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

  Future<WeatherCode> updateLocationWeather(GeoInfo geoInfo) async {
    WeatherIntegration? wi = weatherIntegration;
    if (wi != null) {
      loading = true;
      notifyListeners();
      Weather locationWeather = await wi.getGeoInfoWeather(geoInfo);
      currentWeather = locationWeather;
      loading = false;
      notifyListeners();
      return locationWeather.weatherCode;
    }
    return WeatherCode.none;
  }
}
