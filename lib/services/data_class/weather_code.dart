
import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

enum WeatherCode {
  none,
  clear,
  cloudy,
  fog,
  drizzle,
  freezingDrizzle,
  rain,
  freezingRain,
  snow,
  rainShower,
  snowShower,
  thunderstorm
}

extension WeatherCodeExtension on WeatherCode{
  String getWeatherIcon(bool isDay) {
    return switch(this){
      WeatherCode.none => "svgs/day-fog.svg" ,
      WeatherCode.clear => isDay ? "svgs/day-sunny.svg" : "svgs/night-clear.svg",
      WeatherCode.cloudy =>  isDay ? "svgs/day-cloudy.svg" : "svgs/night-cloudy.svg",
      WeatherCode.fog =>  isDay ? "svgs/day-fog.svg" : "svgs/night-fog.svg",
      WeatherCode.drizzle =>  isDay ? "svgs/day-drizzle.svg" : "svgs/night-drizzle.svg",
      WeatherCode.freezingDrizzle =>  isDay ? "svgs/day-drizzle.svg" : "svgs/night-drizzle.svg",
      WeatherCode.rain =>  isDay ? "svgs/day-rain.svg" : "svgs/night-rain.svg",
      WeatherCode.freezingRain =>  isDay ? "svgs/day-rain-freeze.svg" : "svgs/night-rain-freeze.svg",
      WeatherCode.snow =>  "svgs/show.svg",
      WeatherCode.rainShower =>  isDay ? "svgs/day-showers.svg" : "svgs/night-showers.svg",
      WeatherCode.snowShower =>  isDay ? "svgs/day-snow-showers.svg" : "svgs/night-snow-showers.svg",
      WeatherCode.thunderstorm =>  isDay ? "svgs/day-thunderstorm.svg" : "svgs/night-thunderstorm.svg",
    };
  }

  String get displayName => switch(this){
    WeatherCode.none => "None",
    WeatherCode.clear => "Clear Sky",
    WeatherCode.cloudy => "Cloudy",
    WeatherCode.fog => "Fog",
    WeatherCode.drizzle => "Drizzle",
    WeatherCode.freezingDrizzle => "Freezing Drizzle",
    WeatherCode.rain => "Rain",
    WeatherCode.freezingRain => "Freezing Rain",
    WeatherCode.snow => "Snow",
    WeatherCode.rainShower => "Rain Shower",
    WeatherCode.snowShower => "Snow Shower",
    WeatherCode.thunderstorm => "Thunderstorm",
  };

  ColorScheme getColorScheme(Brightness brightness){
    if(brightness == Brightness.light){
      return colorScheme;
    } else {
      return darkColorScheme;
    }
  }

  ColorScheme get colorScheme {
    return switch(this){
      WeatherCode.none => kCloudyCS,
      WeatherCode.clear => kClearCS,
      WeatherCode.cloudy => kCloudyCS,
      WeatherCode.fog => kFogCS,
      WeatherCode.drizzle => kDrizzleCS,
      WeatherCode.freezingDrizzle => kFreezeDrizzleCS,
      WeatherCode.rain => kRainCS,
      WeatherCode.freezingRain => kFreezeRainCS,
      WeatherCode.snow => kSnowCS,
      WeatherCode.rainShower => kRainShowerCS,
      WeatherCode.snowShower => kSnowShowerCS,
      WeatherCode.thunderstorm => kThunderstormCS,
    };
  }

  ColorScheme get darkColorScheme{
    return switch(this){
      WeatherCode.none => kCloudyDarkCS,
      WeatherCode.clear => kClearDarkCS,
      WeatherCode.cloudy => kCloudyDarkCS,
      WeatherCode.fog => kFogDarkCS,
      WeatherCode.drizzle => kDrizzleDarkCS,
      WeatherCode.freezingDrizzle => kFreezeDrizzleDarkCS,
      WeatherCode.rain => kRainDarkCS,
      WeatherCode.freezingRain => kFreezeRainDarkCS,
      WeatherCode.snow => kSnowDarkCS,
      WeatherCode.rainShower => kRainShowerDarkCS,
      WeatherCode.snowShower => kSnowShowerDarkCS,
      WeatherCode.thunderstorm => kThunderstormDarkCS,
    };
  }
}