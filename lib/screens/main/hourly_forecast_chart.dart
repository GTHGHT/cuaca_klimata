import 'package:cuaca_klimata/services/data_class/weather_code.dart';
import 'package:cuaca_klimata/services/data_class/weather_forecast.dart';
import 'package:cuaca_klimata/utilities/datetime_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HourlyWeatherChart extends StatelessWidget {
  final List<HourlyWeather> hWeathers;
  final BaseTouchCallback<LineTouchResponse>? touchCallback;

  const HourlyWeatherChart({
    super.key,
    required this.hWeathers,
    this.touchCallback,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1200,
      height: 200,
      child: LineChart(
        LineChartData(
          minX: -0.3,
          maxX: 23.3,
          minY: 0,
          maxY: 100,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          lineBarsData: [
            LineChartBarData(
              color: Theme.of(context).colorScheme.outline,
              barWidth: 4,
              isCurved: false,
              spots: hWeathers.map(
                    (value) => FlSpot(
                      value.time.hour.toDouble(),
                      value.temp,
                    ),
                  )
                  .toList()..sort((a, b) => a.x.compareTo(b.x)),
              dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    final colorScheme =
                        hWeathers[index].weatherCode.getColorScheme(
                              Theme.of(context).brightness,
                            );
                    return FlDotCirclePainter(
                      radius: 6,
                      color: colorScheme.primaryContainer,
                      strokeWidth: 3,
                      strokeColor: colorScheme.primary,
                    );
                  }),
            ),
          ],
          titlesData: FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                getTitlesWidget: (value, meta) => SizedBox(),
                showTitles: true,
                reservedSize: 10,
              ),
            ),
            leftTitles: AxisTitles(
              axisNameWidget: Text("Temperature (°C)"),
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                interval: 20,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                getTitlesWidget: (value, meta) => SizedBox(),
                showTitles: true,
                reservedSize: 10,
              ),
            ),
            bottomTitles: AxisTitles(
              axisNameWidget: Text("Hour"),
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    Widget text;
                    var intVal = value.floor();
                    if (value % 1 == 0) {
                      if (intVal >= hWeathers.length) {
                        text = Text(hWeathers.last.time
                            .add(Duration(hours: intVal - hWeathers.length + 1))
                            .hour24);
                      } else {
                        text = Text(hWeathers[intVal].time.hour24);
                      }
                    } else {
                      text = const Text('');
                    }
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 10,
                      child: text,
                    );
                  }),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.primaryContainer,
                width: 4,
              ),
              left: BorderSide(
                color: Theme.of(context).colorScheme.primaryContainer,
                width: 2,
              ),
              right: const BorderSide(
                color: Colors.transparent,
              ),
              top: const BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            horizontalInterval: 20,
            getDrawingHorizontalLine: (value) => FlLine(
                strokeWidth: 2,
                color: Theme.of(context).colorScheme.outlineVariant,
                dashArray: [6, 4]),
            drawVerticalLine: false,
          ),
          lineTouchData: LineTouchData(
            getTouchedSpotIndicator: (barData, spotIndexes) {
              return spotIndexes.map(
                (spotIndex) {
                  final colorScheme =
                      hWeathers[spotIndex].weatherCode.getColorScheme(
                            Theme.of(context).brightness,
                          );
                  return TouchedSpotIndicatorData(
                    FlLine(color: colorScheme.primary),
                    FlDotData(
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 10,
                          color: colorScheme.surface,
                          strokeWidth: 4,
                          strokeColor: colorScheme.primary,
                        );
                      },
                    ),
                  );
                },
              ).toList();
            },
            touchTooltipData: LineTouchTooltipData(
                fitInsideVertically: true,
                getTooltipColor: (spot) {
                  return Theme.of(context).colorScheme.surfaceContainer;
                },
                maxContentWidth: 2000,
                getTooltipItems: (spot) {
                  return spot.map((value) {
                    var weather = hWeathers.elementAtOrNull(value.spotIndex);
                    var style = TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 14.0, fontWeight: FontWeight.w500);
                    return LineTooltipItem(
                        weather != null
                            ? "${weather.weatherCode.displayName}: ${weather.temp.toString()}°"
                            : "${value.y.toString()}°",
                        style);
                  }).toList();
                }),
            touchCallback: touchCallback,
          ),
        ),
      ),
    );
  }
}
