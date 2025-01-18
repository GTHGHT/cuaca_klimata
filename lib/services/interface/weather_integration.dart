import 'package:cuaca_klimata/services/data_class/geo_info.dart';

import '../data_class/weather.dart';
import '../data_class/weather_forecast.dart';

abstract class WeatherIntegration {
  Future<Weather> getLocationWeather(double lat, double lon);

  Future<Weather> searchLocationWeather(String query);

  Future<WeatherForecast> getWeatherForecast(double lat, double lon);

  Future<Weather> getGeoInfoWeather(GeoInfo geoInfo);
}
