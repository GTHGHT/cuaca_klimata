import 'package:cuaca_klimata/services/data_class/geo_info.dart';
import 'package:flutter/foundation.dart';

import 'data_class/weather.dart';
import 'data_class/weather_code.dart';
import 'data_class/weather_forecast.dart';
import 'interface/geocoding_integration.dart';
import 'interface/weather_integration.dart';
import 'networking.dart';

class OpenMeteoWeather implements WeatherIntegration {
  final openMeteoHeader = "https://api.open-meteo.com/v1/";
  late GeocodingIntegration geocoding;
  final Map<int, String> weatherNameMapping = {
    0: "Clear Sky",
    1: "Mainly Clear",
    2: "Partly Cloudy",
    3: "Overcast",
    45: "Fog",
    48: "Depositing Rime Fog",
    51: "Light Drizzle",
    53: "Moderate Drizzle",
    55: "Dense Drizzle",
    56: "Light Freezing Drizzle",
    57: "Dense Freezing Drizzle",
    61: "Slight Rain",
    63: "Moderate Rain",
    65: "Heavy Rain",
    66: "Light Freezing Rain",
    67: "Heavy Freezing Rain",
    71: "Slight Snow",
    73: "Moderate Snow",
    75: "Heavy Snow",
    77: "Snow Grains",
    80: "Slight Rain Showers",
    81: "Moderate Rain Showers",
    82: "Violent Rain Showers",
    85: "Slight Snow Showers",
    86: "Heavy Snow Showers",
    95: "Thunderstorm",
    96: "Thunderstorm With Slight Hail",
    99: "Thunderstorm With Heavy Hail",
  };

  final Map<int, WeatherCode> weatherCodeMapping = {
    0: WeatherCode.clear,
    1: WeatherCode.cloudy,
    2: WeatherCode.cloudy,
    3: WeatherCode.cloudy,
    45: WeatherCode.fog,
    48: WeatherCode.fog,
    51: WeatherCode.drizzle,
    53: WeatherCode.drizzle,
    55: WeatherCode.drizzle,
    56: WeatherCode.freezingDrizzle,
    57: WeatherCode.freezingDrizzle,
    61: WeatherCode.rain,
    63: WeatherCode.rain,
    65: WeatherCode.rain,
    66: WeatherCode.freezingRain,
    67: WeatherCode.freezingRain,
    71: WeatherCode.snow,
    73: WeatherCode.snow,
    75: WeatherCode.snow,
    77: WeatherCode.snow,
    80: WeatherCode.rainShower,
    81: WeatherCode.rainShower,
    82: WeatherCode.rainShower,
    85: WeatherCode.snowShower,
    86: WeatherCode.snowShower,
    95: WeatherCode.thunderstorm,
    96: WeatherCode.thunderstorm,
    99: WeatherCode.thunderstorm,
  };

  OpenMeteoWeather(this.geocoding);

  @override
  Future<Weather> getCityWeather(String cityName) async {
    GeoInfo cityGeoInfo = await geocoding.getGeoByQuery(cityName);
    String cityWeatherLink = "${openMeteoHeader}forecast"
        "?latitude=${cityGeoInfo.latitude}&longitude=${cityGeoInfo.longitude}"
        "&current=temperature_2m,relative_humidity_2m,is_day,weather_code,"
        "wind_speed_10m,wind_direction_10m,wind_gusts_10m,cloud_cover,"
        "pressure_msl&timezone=auto";
    var response = await NetworkHelper.getAPIResponse(cityWeatherLink);
    Weather resultWeather = _getWeatherFromJson(response)
      ..city = cityGeoInfo.cityName
      ..countryCode = cityGeoInfo.countryCode
    ..countryName = cityGeoInfo.countryName;
    return resultWeather;
  }

  @override
  Future<Weather> getLocationWeather(double lat, double lon) async {
    String currentWeatherLink =
        "${openMeteoHeader}forecast?latitude=$lat&longitude=$lon&current="
        "temperature_2m,relative_humidity_2m,is_day,weather_code,cloud_cover,"
        "pressure_msl,wind_speed_10m,wind_direction_10m,"
        "wind_gusts_10m&timezone=auto";
    debugPrint(currentWeatherLink);
    var response = await NetworkHelper.getAPIResponse(currentWeatherLink);
    GeoInfo currentGeoInfo = await geocoding.getGeoByLocation(lat, lon);
    Weather resultWeather = _getWeatherFromJson(response)
      ..city = currentGeoInfo.cityName
      ..countryCode = currentGeoInfo.countryCode
      ..countryName = currentGeoInfo.countryName;
    return resultWeather;
  }

  @override
  Future<WeatherForecast> getWeatherForecast(double lat, double lon) async {
    String weatherForecastLink =
        "${openMeteoHeader}forecast?latitude=$lat&longitude=$lon"
        "&hourly=temperature_2m,relative_humidity_2m,is_day,weather_code,"
        "wind_speed_10m,cloud_cover,pressure_msl&daily=temperature_2m_min,"
        "temperature_2m_max,precipitation_probability_max,weather_code,"
        "wind_speed_10m_max,sunrise,sunset&past_days=1&forecast_days=6&past_hours=12"
        "&forecast_hours=12&timezone=auto";
    debugPrint(weatherForecastLink);
    var response = await NetworkHelper.getAPIResponse(weatherForecastLink);
    WeatherForecast weatherForecast = _getWeatherForecastFromJson(response);
    return weatherForecast;
  }

  Weather _getWeatherFromJson(Map<String, dynamic> json) {
    Map<String, dynamic> current = json['current'];
    return Weather(
      latitude: json["latitude"],
      longitude: json["longitude"],
      city: "",
      weatherName: _getWeatherName(current["weather_code"]),
      weatherCode: _getWeatherCode(current["weather_code"]),
      isDay: current["is_day"] == 1,
      temp: (current["temperature_2m"] as num).toDouble(),
      cloudCover: (current["cloud_cover"] as num).toInt(),
      windDirection: (current["wind_direction_10m"] as num).toDouble(),
      windSpeed: (current["wind_speed_10m"] as num).toDouble(),
      humidity: (current["relative_humidity_2m"] as num).toInt(),
      pressure: (current["pressure_msl"] as num).toDouble(),
    );
  }

  WeatherForecast _getWeatherForecastFromJson(Map<String, dynamic> json) {
    Map<String, dynamic> dailyJson = json["daily"];
    List<DailyWeather> dwResult = _getDailyList(dailyJson);

    Map<String, dynamic> hourlyJson = json["hourly"];
    List<HourlyWeather> hwResult = _getHourlyList(hourlyJson);

    return WeatherForecast(
      dailyForecast: dwResult,
      hourlyForecast: hwResult,
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  List<HourlyWeather> _getHourlyList(Map<String, dynamic> json) {
    List<String> hTimeJson = json["time"]?.cast<String>() ?? [];
    List<HourlyWeather> hwResult = [];
    for (var i = 0; i < hTimeJson.length; i++) {
      WeatherCode wCode = _getWeatherCode(json["weather_code"]?[i] ?? -1);
      num temp = json["temperature_2m"]?[i] ?? -1.0;
      num humidity = json["relative_humidity_2m"]?[i] ?? -1.0;
      num windSpeed = json["wind_speed_10m"]?[i] ?? -1;
      num cloudCover = json["cloud_cover"]?[i] ?? -1;
      num pressure = json["pressure_msl"]?[i] ?? -1;
      hwResult.add(
        HourlyWeather(
          time: DateTime.tryParse(hTimeJson[i]) ?? DateTime.now(),
          temp: temp.toDouble(),
          humidity: humidity.toInt(),
          isDay: json["is_day"]?[i] == 1,
          windSpeed: windSpeed.toDouble(),
          cloudCover: cloudCover.toInt(),
          pressure: pressure.toDouble(),
          weatherCode: wCode,
        ),
      );
    }
    return hwResult;
  }

  List<DailyWeather> _getDailyList(Map<String, dynamic> json) {
    List<String> dTimeJson = json["time"]?.cast<String>() ?? [];
    List<DailyWeather> dwResult = [];
    for (var i = 0; i < dTimeJson.length; i++) {
      WeatherCode wCode = _getWeatherCode(json["weather_code"]?[i] ?? -1);
      num tempMin = json["temperature_2m_min"]?[i] ?? -1;
      num tempMax = json["temperature_2m_max"]?[i] ?? -1;
      num precipProb = json["precipitation_probability_max"]?[i] ?? -1;
      num windSpeed = json["wind_speed_10m_max"]?[i] ?? -1;
      dwResult.add(
        DailyWeather(
          time: DateTime.tryParse(dTimeJson[i]) ?? DateTime.now(),
          tempMin: tempMin.toDouble(),
          tempMax: tempMax.toDouble(),
          precipProb: precipProb.toInt(),
          windSpeed: windSpeed.toDouble(),
          weatherCode: wCode,
          sunrise: DateTime.tryParse(json["sunrise"]?[i]),
          sunset: DateTime.tryParse(json["sunset"]?[i]),
        ),
      );
    }
    return dwResult;
  }

  WeatherCode _getWeatherCode(int weatherCode) {
    return weatherCodeMapping[weatherCode] ?? WeatherCode.none;
  }

  String _getWeatherName(int weatherCode) {
    return weatherNameMapping[weatherCode] ?? "Cuaca Tidak Ditemukan";
  }

  bool _getIsDay(String timezone, String time) {
    //Consider The DayTime
    DateTime dt = DateTime.tryParse(time) ?? DateTime.now();
    return (dt.hour > 5 && dt.hour < 18);
  }
}
