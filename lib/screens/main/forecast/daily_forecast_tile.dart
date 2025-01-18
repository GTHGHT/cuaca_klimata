import 'package:cuaca_klimata/services/data_class/weather_code.dart';
import 'package:cuaca_klimata/services/data_class/weather_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DailyForecastTile extends StatelessWidget {
  final DailyWeather dailyWeather;
  const DailyForecastTile({super.key, required this.dailyWeather});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        DateFormat("EEEE, d MMM y")
            .format(dailyWeather.time)
            .toString(),
      ),
      subtitle: Text(
        "${dailyWeather.weatherCode.displayName}, ${dailyWeather.tempMin}°-${dailyWeather.tempMax}°",
      ),
      children: <Widget>[
        ListTile(
          leading: SvgPicture.asset(
            dailyWeather.weatherCode.getWeatherIcon(true),
          ),
          title: Text("Weather"),
          trailing: Text(
            dailyWeather.weatherCode.displayName,
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
            "${dailyWeather.tempMin}° - ${dailyWeather.tempMax}°",
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
            "${dailyWeather.precipProb}%",
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
            "${dailyWeather.windSpeed} km/h",
            style: Theme.of(context)
                .textTheme
                .titleSmall,
          ),
        ),
        if (dailyWeather.sunrise != null)
          ListTile(
            leading: SvgPicture.asset(
              "svgs/sunrise.svg",
            ),
            title: Text("Sunrise Time"),
            trailing: Text(
              DateFormat("H:mm")
                  .format(
                dailyWeather.sunrise ?? DateTime.now(),
              )
                  .toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall,
            ),
          ),
        if (dailyWeather.sunset != null)
          ListTile(
            leading: SvgPicture.asset(
              "svgs/sunset.svg",
            ),
            title: Text("Sunset Time"),
            trailing: Text(
              DateFormat("H:mm")
                  .format(
                dailyWeather.sunset ?? DateTime.now(),
              )
                  .toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall,
            ),
          ),
      ],
    );
  }
}
