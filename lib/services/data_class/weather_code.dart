import 'dart:ui';

import 'package:flutter/gestures.dart';
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
  //
  // List<Color> get backgroundColors {
  //   return switch(this){
  //     WeatherCode.none => [kFogCS.surface, kFogCS.primaryFixedDim],
  //     WeatherCode.clear => [kClearCS.surface, kClearCS.primaryFixedDim],
  //     WeatherCode.cloudy => [kCloudyCS.surface, kCloudyCS.primaryFixedDim],
  //     WeatherCode.fog => [kFogCS.surface, kFogCS.primaryFixedDim],
  //     WeatherCode.drizzle => [kDrizzleCS.surface, kDrizzleCS.primaryFixedDim],
  //     WeatherCode.freezingDrizzle => [kFreezeDrizzleCS.surface, kFreezeDrizzleCS.primaryFixedDim],
  //     WeatherCode.rain => [kRainCS.surface, kRainCS.primaryFixedDim],
  //     WeatherCode.freezingRain => [kFreezeRainCS.surface, kFreezeRainCS.primaryFixedDim],
  //     WeatherCode.snow => [kSnowCS.surface, kSnowCS.primaryFixedDim],
  //     WeatherCode.rainShower => [kRainShowerCS.surface, kRainShowerCS.primaryFixedDim],
  //     WeatherCode.snowShower => [kSnowShowerCS.surface, kSnowShowerCS.primaryFixedDim],
  //     WeatherCode.thunderstorm => [kThunderstormCS.surface, kThunderstormCS.primaryFixedDim],
  //   };
  // }

  // Color get dateTextColor {
  //   return switch(this){
  //     WeatherCode.none => throw UnimplementedError(),
  //     WeatherCode.clear => kBlueDateTextColor,
  //     WeatherCode.cloudy => throw UnimplementedError(),
  //     WeatherCode.fog => throw UnimplementedError(),
  //     WeatherCode.drizzle => throw UnimplementedError(),
  //     WeatherCode.freezingDrizzle => throw UnimplementedError(),
  //     WeatherCode.rain => kRedDateTextColor,
  //     WeatherCode.freezingRain => throw UnimplementedError(),
  //     WeatherCode.snow => throw UnimplementedError(),
  //     WeatherCode.rainShower => throw UnimplementedError(),
  //     WeatherCode.snowShower => throw UnimplementedError(),
  //     WeatherCode.thunderstorm => kBlackDateTextColor,
  //   };
  // }
  //
  //  Color get detailTextColor {
  //   return switch(this){
  //     WeatherCode.none => throw UnimplementedError(),
  //     WeatherCode.clear => kBlueDetailTextColor,
  //     WeatherCode.cloudy => throw UnimplementedError(),
  //     WeatherCode.fog => throw UnimplementedError(),
  //     WeatherCode.drizzle => throw UnimplementedError(),
  //     WeatherCode.freezingDrizzle => throw UnimplementedError(),
  //     WeatherCode.rain => kRedDetailTextColor,
  //     WeatherCode.freezingRain => throw UnimplementedError(),
  //     WeatherCode.snow => throw UnimplementedError(),
  //     WeatherCode.rainShower => throw UnimplementedError(),
  //     WeatherCode.snowShower => throw UnimplementedError(),
  //     WeatherCode.thunderstorm => kBlackDetailTextColor,
  //   };
  // }
  //
  //  Color get cardColor {
  //   return switch(this){
  //     WeatherCode.none => throw UnimplementedError(),
  //     WeatherCode.clear => kBlueCardColor,
  //     WeatherCode.cloudy => throw UnimplementedError(),
  //     WeatherCode.fog => throw UnimplementedError(),
  //     WeatherCode.drizzle => throw UnimplementedError(),
  //     WeatherCode.freezingDrizzle => throw UnimplementedError(),
  //     WeatherCode.rain => kRedCardColor,
  //     WeatherCode.freezingRain => throw UnimplementedError(),
  //     WeatherCode.snow => throw UnimplementedError(),
  //     WeatherCode.rainShower => throw UnimplementedError(),
  //     WeatherCode.snowShower => throw UnimplementedError(),
  //     WeatherCode.thunderstorm => kBlackCardColor,
  //   };
  // }

  String get weatherIconLocation {
    return switch(this){
      WeatherCode.none => "images/broken_white.png",
      WeatherCode.clear => "images/clear_white.png",
      WeatherCode.cloudy => "images/cloud_white.png",
      WeatherCode.fog => "images/dust_white.png",
      WeatherCode.drizzle => "images/drizzle_white.png",
      WeatherCode.freezingDrizzle => throw UnimplementedError(),
      WeatherCode.rain => "images/rain_white.png",
      WeatherCode.freezingRain => throw UnimplementedError(),
      WeatherCode.snow => "images/snow_white.png",
      WeatherCode.rainShower => "images/fewc_white.png",
      WeatherCode.snowShower => throw UnimplementedError(),
      WeatherCode.thunderstorm => "images/storm_white.png",
    };
  }

  ColorScheme get colorScheme {
    return switch(this){
      WeatherCode.none => kFogCS,
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
      WeatherCode.none => kFogDarkCS,
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