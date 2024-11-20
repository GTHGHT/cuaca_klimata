import 'package:intl/intl.dart';

import 'weather_code.dart';

class WeatherForecast {
  late List<DailyWeather> dailyForecast;
  late List<HourlyWeather> hourlyForecast;
  late double latitude;
  late double longitude;

  WeatherForecast(
      {required this.dailyForecast,
      required this.hourlyForecast,
      required this.latitude,
      required this.longitude});
}

class DailyWeather {
  late DateTime time;
  late double tempMin;
  late double tempMax;

  // Maximum Precipitation Probability
  late int precipProb;

  // Maximum Wind Speed For 10 Minutes
  late double windSpeed;
  late WeatherCode weatherCode;

  DateTime? sunrise;
  DateTime? sunset;

  DailyWeather(
      {required this.time,
      required this.tempMin,
      required this.tempMax,
      required this.precipProb,
      required this.windSpeed,
      required this.weatherCode,
      this.sunrise,
      this.sunset});

  String get weekDay {
    return DateFormat.EEEE().format(time);
  }
}

class HourlyWeather {
  late DateTime time;
  late double temp;
  late int humidity;
  late bool isDay;
  late double windSpeed;
  late int cloudCover;
  late double pressure;
  late WeatherCode weatherCode;

  HourlyWeather(
      {required this.time,
      required this.temp,
      required this.humidity,
      required this.isDay,
      required this.windSpeed,
      required this.cloudCover,
      required this.pressure,
      required this.weatherCode});

  String get hour12 {
    return time.hour < 13
        ? (time.hour == 0 ? "12 PM" : "${time.hour} AM")
        : "${time.hour - 12} PM";
  }

  String get hour24 => "${time.hour}:${time.minute.toString().padLeft(2,'0')}";
}
