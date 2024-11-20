import '../data_class/weather.dart';
import '../data_class/weather_forecast.dart';

abstract class WeatherIntegration {
  Future<Weather> getLocationWeather(double lat, double lon);

  Future<Weather> getCityWeather(String cityName);

  Future<WeatherForecast> getWeatherForecast(double lat, double lon);
}
