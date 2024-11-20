import 'package:cuaca_klimata/utilities/double_extension.dart';

import '../screens/loading_widget.dart';
import '../services/data_class/weather_code.dart';
import '../services/data_class/weather_forecast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/weathers.dart';
import '../utilities/constants.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        centerTitle: true,
        backgroundColor: kScaffoldBGColor,
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

                      return HourForecastGrid(
                        weatherIcon: hourForecast?.weatherCode.weatherIconLocation ?? "images/dust_white.png",
                        hour: hourForecast?.hour24 ?? "00:00",
                        temp: hourForecast?.temp.toDouble() ?? 0.0,
                      );
                    },
                    separatorBuilder: (_, __) => const VerticalDivider(),
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
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      DailyWeather? dayForecast = context
                          .watch<Weathers>()
                          .weatherForecast
                          ?.dailyForecast[index];
                      return DayForecastCard(
                        weatherIcon: dayForecast?.weatherCode.weatherIconLocation?? "images/dust_white.png",
                        weekDay: dayForecast?.weekDay ?? "None",
                        temp: dayForecast?.tempMax ?? 0.0,
                        feelsLike: dayForecast?.tempMin ?? 0.0,
                        textColor: dayForecast?.weatherCode.dateTextColor?? kBlackDateTextColor,
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(),
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

  const DayForecastCard({super.key, 
    required this.weatherIcon,
    required this.weekDay,
    required this.temp,
    required this.feelsLike,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: kForecastTileColor, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
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
            child: Image.asset(
              weatherIcon,
              width: 44,
              height: 44,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${temp.toStringFirstDecimal()}°",
                style: kConditionTextStyle,
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

  const HourForecastGrid({super.key, 
    required this.weatherIcon,
    required this.hour,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kForecastTileColor,
      ),
      height: 100,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(hour),
          Image.asset(
            weatherIcon,
            height: 40,
            width: 40,
          ),
          Text("$temp°")
        ],
      ),
    );
  }
}