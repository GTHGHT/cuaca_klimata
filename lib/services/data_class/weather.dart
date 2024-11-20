import '../data_class/weather_code.dart';

class Weather {
  late double latitude;
  late double longitude;
  late String city;
  late String weatherName;
  late WeatherCode weatherCode;
  late bool isDay;
  late double temp;
  late int cloudCover;
  late double windDirection;
  late double windSpeed;
  late int humidity;
  late double pressure;

  Weather({
      required this.latitude,
      required this.longitude,
      required this.city,
      required this.weatherName,
      required this.weatherCode,
      required this.isDay,
      required this.temp,
      required this.cloudCover,
      required this.windDirection,
      required this.windSpeed,
      required this.humidity,
      required this.pressure
  });
}


