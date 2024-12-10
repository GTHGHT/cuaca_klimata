import 'package:cuaca_klimata/services/data_class/weather_code.dart';
import 'package:cuaca_klimata/utilities/double_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../services/data_class/weather_forecast.dart';
import '../../../services/weather_forecast_service.dart';
import '../../../services/weather_service.dart';
import '../weather_info_item.dart';
import 'hourly_forecast_chart.dart';

class ForecastBottomSheet extends StatefulWidget {
  const ForecastBottomSheet({super.key});

  @override
  State<ForecastBottomSheet> createState() => _ForecastBottomSheetState();
}

class _ForecastBottomSheetState extends State<ForecastBottomSheet> {
  double _sheetPosition = 0.2;
  final double _dragSensitivity = 750;
  late DraggableScrollableController sheetController;

  int touchedSpot = -1;

  @override
  void initState() {
    sheetController = DraggableScrollableController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: sheetController,
      minChildSize: 0.2,
      initialChildSize: _sheetPosition,
      builder: (BuildContext context, ScrollController scrollController) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onVerticalDragUpdate: (DragUpdateDetails details) {
                  _sheetPosition -= details.delta.dy / _dragSensitivity;
                  if (_sheetPosition < 0.2) {
                    _sheetPosition = 0.2;
                  }
                  if (_sheetPosition > 1.0) {
                    _sheetPosition = 1.0;
                  }
                  sheetController.jumpTo(_sheetPosition);
                },
                onVerticalDragEnd: (DragEndDetails details) {
                  if (_sheetPosition == 1.0 &&
                      details.primaryVelocity?.floor() != 0) {
                    final currentWeather =
                        context.read<WeatherService>().currentWeather;
                    if (currentWeather != null) {
                      context
                          .read<WeatherForecastService>()
                          .updateWeatherForecast(currentWeather.latitude,
                              currentWeather.longitude);
                    }
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 24,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            // margin:
                            //     const EdgeInsets.symmetric(vertical: 8.0),
                            width: 48,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.outline,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          "Weather Forecast",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: ListView(
                  controller: scrollController,
                  children: [
                    if (context
                            .watch<WeatherForecastService>()
                            .weatherForecast ==
                        null) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        child: Center(
                          child: context.watch<WeatherForecastService>().loading
                              ? CircularProgressIndicator()
                              : Text(
                                  "Scroll Up To Load",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                        ),
                      ),
                    ] else ...[
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          "Hourly Forecast",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Builder(builder: (context) {
                          WeatherForecast? wForecast = context
                              .watch<WeatherForecastService>()
                              .weatherForecast;
                          if (wForecast != null) {
                            return HourlyWeatherChart(
                              hWeathers: wForecast.hourlyForecast,
                              touchCallback: (event, response) {
                                if (event is FlTapUpEvent) {
                                  var touchedIndex =
                                      response?.lineBarSpots?.firstOrNull;
                                  if (touchedIndex != null) {
                                    setState(() {
                                      touchedSpot = touchedIndex.spotIndex;
                                    });
                                  }
                                }
                              },
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                      ),
                      if (touchedSpot != -1)
                        Builder(builder: (context) {
                          var hWeathers = context
                              .watch<WeatherForecastService>()
                              .weatherForecast
                              ?.hourlyForecast
                              .elementAtOrNull(touchedSpot);
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    WeatherInfoItem(
                                      iconPath: (hWeathers?.isDay ?? false)
                                          ? "svgs/day-sunny.svg"
                                          : "svgs/night-clear.svg",
                                      label: "Time",
                                      value: DateFormat("HH:mm")
                                          .format(
                                              hWeathers?.time ?? DateTime.now())
                                          .toString(),
                                    ),
                                    WeatherInfoItem(
                                      iconPath: hWeathers?.weatherCode
                                              .getWeatherIcon(
                                                  hWeathers.isDay) ??
                                          "svgs/day-fog.svg",
                                      label: "Weather",
                                      value:
                                          hWeathers?.weatherCode.displayName ??
                                              "",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    WeatherInfoItem(
                                      iconPath: "svgs/thermometer.svg",
                                      label: "Temperature",
                                      value:
                                          "${hWeathers?.temp.toStringFirstDecimal()}°",
                                    ),
                                    WeatherInfoItem(
                                      iconPath: "svgs/cloud-cover.svg",
                                      label: "Cloud Cover",
                                      value: "${hWeathers?.cloudCover}%",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    WeatherInfoItem(
                                      iconPath: "svgs/wind-speed.svg",
                                      label: "Wind Speed",
                                      value: "${hWeathers?.windSpeed} km/h",
                                    ),
                                    WeatherInfoItem(
                                      iconPath: "svgs/humidity.svg",
                                      label: "Humidity",
                                      value: "${hWeathers?.humidity}%",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Daily Forecast",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Builder(builder: (context) {
                        WeatherForecast? wForecast = context
                            .watch<WeatherForecastService>()
                            .weatherForecast;
                        if (wForecast != null) {
                          return Column(
                            children: wForecast.dailyForecast.map((value) {
                              return ExpansionTile(
                                title: Text(
                                  DateFormat("EEEE, d MMM y")
                                      .format(value.time)
                                      .toString(),
                                ),
                                subtitle: Text(
                                  "${value.weatherCode.displayName}, ${value.tempMin}°-${value.tempMax}°",
                                ),
                                children: <Widget>[
                                  ListTile(
                                    leading: SvgPicture.asset(
                                      value.weatherCode.getWeatherIcon(true),
                                    ),
                                    title: Text("Weather"),
                                    trailing: Text(
                                      value.weatherCode.displayName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                  ListTile(
                                    leading: SvgPicture.asset(
                                      "svgs/thermometer.svg",
                                    ),
                                    title: Text("Temperature"),
                                    trailing: Text(
                                      "${value.tempMin}° - ${value.tempMax}°",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                  ListTile(
                                    leading: SvgPicture.asset(
                                      "svgs/precipitation.svg",
                                    ),
                                    title: Text("Precipitation Probability"),
                                    trailing: Text(
                                      "${value.precipProb}%",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                  ListTile(
                                    leading: SvgPicture.asset(
                                      "svgs/wind-speed.svg",
                                    ),
                                    title: Text("Wind Speed"),
                                    trailing: Text(
                                      "${value.windSpeed} km/h",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                  if (value.sunrise != null)
                                    ListTile(
                                      leading: SvgPicture.asset(
                                        "svgs/sunrise.svg",
                                      ),
                                      title: Text("Sunrise Time"),
                                      trailing: Text(
                                        DateFormat("H:mm")
                                            .format(
                                              value.sunrise ?? DateTime.now(),
                                            )
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                  if (value.sunset != null)
                                    ListTile(
                                      leading: SvgPicture.asset(
                                        "svgs/sunset.svg",
                                      ),
                                      title: Text("Sunset Time"),
                                      trailing: Text(
                                        DateFormat("H:mm")
                                            .format(
                                              value.sunset ?? DateTime.now(),
                                            )
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                ],
                              );
                            }).toList(),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
