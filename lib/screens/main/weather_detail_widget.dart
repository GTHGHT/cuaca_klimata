import 'package:cuaca_klimata/utilities/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/notifier/weather_notifier.dart';
import 'weather_info_item.dart';

class WeatherDetailWidget extends StatelessWidget {
  final bool withCard;

  const WeatherDetailWidget({super.key, this.withCard = false});

  @override
  Widget build(BuildContext context) {
    return withCard
        ? Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: _buildContent(context, true),
    )
        : Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: _buildContent(context, false),
    );
  }

  Widget _buildContent(BuildContext context, bool isCard) {
    final circleColor = isCard ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.surfaceContainer;
    final iconColor = isCard ? Theme.of(context).colorScheme.surfaceTint : Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Builder(builder: (context) {
                double? feelsLike =
                    context.watch<WeatherNotifier>().currentWeather?.feelsLike;
                return WeatherInfoItem(
                  iconPath: feelsLike != null
                      ? "svgs/thermometer.svg"
                      : "svgs/location.svg",
                  label: feelsLike != null ? "Feels Like" : "Coordinate",
                  value: feelsLike != null
                      ? "${feelsLike.toStringFirstDecimal()}°"
                      : context.select<WeatherNotifier, String>((value) =>
                  "${value.currentWeather?.latitude};${value.currentWeather?.longitude}"),
                  circleColor: circleColor,
                  iconColor: iconColor,
                );
              }),
              WeatherInfoItem(
                iconPath: 'svgs/cloud-cover.svg',
                label: "Cloud Cover",
                value:
                "${context.watch<WeatherNotifier>().currentWeather?.cloudCover}%",
                circleColor: circleColor,
                iconColor: iconColor,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              WeatherInfoItem(
                iconPath: 'svgs/wind-speed.svg',
                label: "Wind Speed",
                value:
                "${context.watch<WeatherNotifier>().currentWeather?.windSpeed} km/h",
                circleColor: circleColor,
                iconColor: iconColor,
              ),
              WeatherInfoItem(
                iconPath: 'svgs/wind-direction.svg',
                label: "Wind Direction",
                value:
                "${context.watch<WeatherNotifier>().currentWeather?.windDirection}°",
                circleColor: circleColor,
                iconColor: iconColor,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              WeatherInfoItem(
                iconPath: 'svgs/humidity.svg',
                label: "Humidity",
                value: "${context.watch<WeatherNotifier>().currentWeather?.humidity}%",
                circleColor: circleColor,
                iconColor: iconColor,
              ),
              WeatherInfoItem(
                iconPath: 'svgs/pressure.svg',
                label: "Pressure",
                value:
                "${context.watch<WeatherNotifier>().currentWeather?.pressure} hPa",
                circleColor: circleColor,
                iconColor: iconColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}