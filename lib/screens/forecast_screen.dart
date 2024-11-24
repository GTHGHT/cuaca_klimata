import 'package:cuaca_klimata/utilities/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../screens/loading_widget.dart';
import '../services/data_class/weather_code.dart';
import '../services/data_class/weather_forecast.dart';
import '../services/weathers.dart';
import '../utilities/constants.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        // elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        title: Text(
          DateFormat("EEEE, d MMMM y").format(DateTime.now()).toString(),
        ),
      ),
      body: context.select<Weathers, bool>((value) => value.loading)
          ? const LoadingWidget()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  "Hourly Forecast",
                  textAlign: TextAlign.center,
                  style: kForecastTitleTextStyle,
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      HourlyWeather? hourForecast = context
                          .watch<Weathers>()
                          .weatherForecast
                          ?.hourlyForecast[index];
                      if (hourForecast != null) {
                        return HourForecastGrid(
                          weatherIcon: hourForecast.weatherCode
                              .getWeatherIcon(hourForecast.isDay),
                          hour: hourForecast.hour24,
                          temp: hourForecast.temp,
                          contentsColor: hourForecast.weatherCode
                              .getColorScheme(Theme.of(context).brightness)
                              .primary,
                          containerColor: hourForecast.weatherCode
                              .getColorScheme(Theme.of(context).brightness)
                              .surfaceContainer,
                        );
                      } else {
                        return const HourForecastGrid(
                          weatherIcon: "svgs/day-sunny.svg",
                          hour: "-",
                          temp: 0.0,
                        );
                      }
                    },
                    separatorBuilder: (_, __) => const SizedBox.square(
                      dimension: 8,
                    ),
                    itemCount: context.select<Weathers, int>((value) =>
                        value.weatherForecast?.hourlyForecast.length ?? 0),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Daily Forecast",
                  textAlign: TextAlign.center,
                  style: kForecastTitleTextStyle,
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      WeatherForecast? weatherForecast =
                          context.watch<Weathers>().weatherForecast;
                      if (weatherForecast != null) {
                        DailyWeather dayForecast =
                            weatherForecast.dailyForecast[index];
                        int forecastLength =
                            weatherForecast.dailyForecast.length;
                        BorderRadius borderRadius = index == 0
                            ? BorderRadius.vertical(top: Radius.circular(16))
                            : index == forecastLength - 1
                                ? BorderRadius.vertical(
                                    bottom: Radius.circular(16))
                                : BorderRadius.zero;
                        return DayForecastCard(
                          weatherIcon:
                              dayForecast.weatherCode.getWeatherIcon(true),
                          weekDay: dayForecast.weekDay,
                          temp: dayForecast.tempMin,
                          feelsLike: dayForecast.tempMax,
                          textColor: dayForecast.weatherCode
                              .getColorScheme(Theme.of(context).brightness)
                              .primary,
                          borderRadius: borderRadius,
                        );
                      } else {
                        return const DayForecastCard(
                          weatherIcon: "svgs/snow.svg",
                          weekDay: "weekDay",
                          temp: 0.0,
                          feelsLike: 0.0,
                        );
                      }
                    },
                    itemCount: context.select<Weathers, int>((value) =>
                        value.weatherForecast?.dailyForecast.length ?? 0),
                  ),
                ),
              ],
            ),
    );
  }
}

class DayForecastCard extends StatelessWidget {
  final String weatherIcon;
  final String weekDay;
  final double temp;
  final double feelsLike;
  final Color textColor;
  final BorderRadiusGeometry? borderRadius;

  const DayForecastCard({
    super.key,
    required this.weatherIcon,
    required this.weekDay,
    required this.temp,
    required this.feelsLike,
    this.textColor = Colors.black,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 1,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              weekDay,
              style: const TextStyle(
                fontFamily: "Noto Sans",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SvgPicture.asset(
              weatherIcon,
              width: 44,
              height: 44,
              colorFilter: ColorFilter.mode(
                textColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${temp.toStringFirstDecimal()}°",
                style: kConditionTextStyle.copyWith(
                  color: textColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${feelsLike.toStringFirstDecimal()}°",
                style: kConditionTextStyle.copyWith(
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HourForecastGrid extends StatelessWidget {
  final String weatherIcon;
  final String hour;
  final double temp;
  final Color contentsColor;
  final Color containerColor;

  const HourForecastGrid(
      {super.key,
      required this.weatherIcon,
      required this.hour,
      required this.temp,
      this.contentsColor = Colors.black,
      this.containerColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: containerColor,
      ),
      height: 100,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            hour,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: contentsColor),
          ),
          SvgPicture.asset(
            weatherIcon,
            height: 40,
            width: 40,
            colorFilter: ColorFilter.mode(contentsColor, BlendMode.srcIn),
          ),
          Text(
            "$temp°",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: contentsColor),
          )
        ],
      ),
    );
  }
}
