import 'package:cuaca_klimata/services/interface/geocoding_integration.dart';
import 'package:cuaca_klimata/services/nominatim_geocoding.dart';
import 'package:cuaca_klimata/services/open_meteo_weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/location.dart';
import 'data_class/weather_code.dart';
import 'data_class/weather_forecast.dart';
import 'data_class/weather.dart';
import 'interface/weather_integration.dart';

class Weathers extends ChangeNotifier {
  Weather? currentWeather;
  WeatherForecast? weatherForecast;
  WeatherIntegration? _weatherIntegration;

  // TODO: Add weather history
  bool loading;

  Weathers(this._weatherIntegration) : loading = true {
    if(_weatherIntegration == null){
      loadWeatherIntegration();
    }
  }

  Future<void> loadWeatherIntegration() async {
    SharedPreferencesAsync spAsync = SharedPreferencesAsync();
    String? geoServicePref = await spAsync.getString('geocoding_integration');
    GeocodingIntegration geoWeatherService = switch (geoServicePref) {
      'nominatim' => NominatimGeocoding(),
      _ => NominatimGeocoding()
    };

    String? wServicePref = await spAsync.getString('weather_integration');
    WeatherIntegration currentWeatherService = switch (wServicePref) {
      "open_meteo" => OpenMeteoWeather(geoWeatherService),
      _ => OpenMeteoWeather(geoWeatherService),
    };

    _weatherIntegration = currentWeatherService;
    loading = false;
    notifyListeners();
  }

  Future<WeatherCode> updateCurrentLocationWeather() async {
    WeatherIntegration? wi = _weatherIntegration;
    if (wi != null) {
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
      if (weatherForecast?.latitude == weather.latitude &&
          weatherForecast?.longitude == weather.longitude) {
        weatherForecast = null;
      }
      loading = false;
      notifyListeners();
      return weather.weatherCode;
    }
    return WeatherCode.none;
  }

  Future<void> updateWeatherForecast() async {
    WeatherIntegration? wi = _weatherIntegration;
    if (wi != null) {
      var saveCurrentWeather = currentWeather;
      if (weatherForecast == null &&
          saveCurrentWeather != null &&
          saveCurrentWeather.latitude != weatherForecast?.latitude &&
          saveCurrentWeather.longitude != weatherForecast?.longitude) {
        loading = true;
        notifyListeners();
        WeatherForecast result = await wi.getWeatherForecast(
            saveCurrentWeather.latitude, saveCurrentWeather.longitude);

        weatherForecast = result;
        loading = false;
        notifyListeners();
      }
    }
  }

  Future<void> updateCityWeather(String city) async {
    WeatherIntegration? wi = _weatherIntegration;
    if (wi != null) {
      if (city.isEmpty) {
        return;
      }
      loading = true;
      notifyListeners();
      city = city.trim().replaceAll(" ", "%20");
      Weather cityWeather = await wi.getCityWeather(city);
      if (weatherForecast?.latitude != cityWeather.latitude &&
          weatherForecast?.longitude != cityWeather.longitude) {
        weatherForecast = null;
      }
      currentWeather = cityWeather;
      loading = false;
      notifyListeners();
    }
  }
}
