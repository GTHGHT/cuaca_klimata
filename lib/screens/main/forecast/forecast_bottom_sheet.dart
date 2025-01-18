import 'package:cuaca_klimata/screens/main/forecast/daily_forecast_tile.dart';
import 'package:cuaca_klimata/services/data_class/weather_code.dart';
import 'package:cuaca_klimata/utilities/double_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../services/data_class/weather_forecast.dart';
import '../../../services/notifier/weather_forecast_notifier.dart';
import '../../../services/notifier/weather_notifier.dart';
import '../weather_info_item.dart';
import 'hourly_forecast_chart.dart';

class ForecastBottomSheet extends StatefulWidget {
  const ForecastBottomSheet({super.key});

  @override
  State<ForecastBottomSheet> createState() => _ForecastBottomSheetState();
}

class _ForecastBottomSheetState extends State<ForecastBottomSheet>
    with TickerProviderStateMixin {
  double _sheetPosition = 0.2;
  final double _dragSensitivity = 750;
  late DraggableScrollableController _sheetController;

  late final AnimationController _animController;

  int touchedSpot = -1;

  @override
  void initState() {
    _animController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _sheetController = DraggableScrollableController();
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _sheetController,
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
                  _sheetController.jumpTo(_sheetPosition);
                },
                onVerticalDragEnd: (DragEndDetails details) {
                  if (_sheetPosition == 1.0 &&
                      details.primaryVelocity?.floor() != 0) {
                    final currentWeather =
                        context.read<WeatherNotifier>().currentWeather;
                    if (currentWeather != null) {
                      context
                          .read<WeatherForecastNotifier>()
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
                  children: _buildContent(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildContent(BuildContext context) {
    if (context.watch<WeatherForecastNotifier>().loading) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 48,
            horizontal: 16,
          ),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ];
    } else if (context
                .watch<WeatherForecastNotifier>()
                .weatherForecast
                ?.latitude !=
            context.watch<WeatherNotifier>().currentWeather?.latitude &&
        context.watch<WeatherForecastNotifier>().weatherForecast?.longitude !=
            context.watch<WeatherNotifier>().currentWeather?.longitude) {
      return [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
          child: Center(
            child: Text(
              "Scroll Up To Load",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ];
    } else {
      return _buildForecastContent(context);
    }
  }

  List<Widget> _buildForecastContent(BuildContext context) {
    return [
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
          WeatherForecast? wForecast =
              context.watch<WeatherForecastNotifier>().weatherForecast;
          if (wForecast != null) {
            return HourlyWeatherChart(
              hWeathers: wForecast.hourlyForecast,
              touchCallback: _hourlyChartCallback
            );
          } else {
            return SizedBox();
          }
        }),
      ),
      SizedBox(
        height: 8,
      ),
      SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: _animController,
          curve: Curves.ease,
        ),
        axis: Axis.vertical,
        axisAlignment: -1,
        child: Builder(builder: (context) {
          var hWeathers = touchedSpot != -1
              ? context
                  .watch<WeatherForecastNotifier>()
                  .weatherForecast
                  ?.hourlyForecast
                  .elementAtOrNull(touchedSpot)
              : null;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildHourlyForecastInfo(hWeathers),
          );
        }),
      ),
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
        WeatherForecast? wForecast =
            context.watch<WeatherForecastNotifier>().weatherForecast;
        if (wForecast != null) {
          return Column(
            children: wForecast.dailyForecast.map((value) {
              return DailyForecastTile(dailyWeather: value);
            }).toList(),
          );
        } else {
          return SizedBox();
        }
      }),
    ];
  }

  Column _buildHourlyForecastInfo(HourlyWeather? hWeathers) {
    return Column(
      children: [
        Row(
          children: [
            WeatherInfoItem(
              iconPath: (hWeathers?.isDay ?? false)
                  ? "svgs/day-sunny.svg"
                  : "svgs/night-clear.svg",
              label: "Time",
              value: DateFormat("HH:mm")
                  .format(hWeathers?.time ?? DateTime.now())
                  .toString(),
            ),
            WeatherInfoItem(
              iconPath:
                  hWeathers?.weatherCode.getWeatherIcon(hWeathers.isDay) ??
                      "svgs/day-fog.svg",
              label: "Weather",
              value: hWeathers?.weatherCode.displayName ?? "",
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
              value: "${hWeathers?.temp.toStringFirstDecimal()}°",
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
    );
  }

  void _hourlyChartCallback(FlTouchEvent event,
  LineTouchResponse? response){
    if (event is FlTapUpEvent) {
      var touchedIndex =
          response?.lineBarSpots?.firstOrNull?.spotIndex ?? -1;
      setState(() {
        if (touchedIndex != -1) {
          touchedSpot = touchedIndex;
        }
        if (touchedIndex == -1 && _animController.value == 1) {
          _animController.reverse(from: 1);
        } else if (touchedIndex != -1 &&
            _animController.value == 0) {
          _animController.forward(from: 0);
        }
      });
    }
  }

}
