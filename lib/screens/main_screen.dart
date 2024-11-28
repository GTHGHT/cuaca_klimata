import 'package:cuaca_klimata/services/data_class/weather_code.dart';
import 'package:cuaca_klimata/utilities/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../screens/loading_widget.dart';
import '../services/weathers.dart';
import '../utilities/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: context.select<Weathers, bool>((value) => value.loading)
            ? const LoadingWidget()
            : buildScreen(context),
      ),
    );
  }

  Widget buildScreen(BuildContext context) {
    setState(() {
      controller.forward(from: 0);
    });
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, -0.05), end: Offset.zero)
          .animate(controller),
      child: FadeTransition(
        opacity: controller,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.secondaryContainer
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopMainAppBar(
                title: DateFormat("d MMM y, H:mm")
                    .format(DateTime.now())
                    .toString(),
              ),
              Builder(builder: (context) {
                String countryCode = context
                        .watch<Weathers>()
                        .currentWeather
                        ?.countryCode
                        .toUpperCase() ??
                    "US";
                String? countryName = context.select<Weathers, String?>(
                    (ws) => ws.currentWeather?.countryName);
                var firstChar = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
                var secondChar = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
                String flag = String.fromCharCode(firstChar) +
                    String.fromCharCode(secondChar);
                return Text(
                  "$flag ${countryName ?? countryCode}",
                  style: Theme.of(context).textTheme.bodyLarge,
                );
              }),
              Text(
                context.select<Weathers, String>(
                  (value) => value.currentWeather?.city ?? "Tidak Ditemukan",
                ),
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(
                height: 15,
              ),
              Builder(builder: (context) {
                var cWeather = context.watch<Weathers>().currentWeather;
                if (cWeather != null) {
                  return SvgPicture.asset(
                    cWeather.weatherCode.getWeatherIcon(cWeather.isDay),
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                    height: 100,
                    width: 100,
                  );
                } else {
                  return const SizedBox.square(dimension: 100);
                }
              }),
              const SizedBox(
                height: 15,
              ),
              Text(
                context.select<Weathers, String>(
                  (value) => value.currentWeather?.weatherName ?? "Kosong",
                ),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              Text(
                "${context.select<Weathers, double>(
                      (value) => value.currentWeather?.temp ?? 0.0,
                    ).toStringFirstDecimal()}°",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const WeatherDetailCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCompactScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.select<Weathers, String>(
                        (value) => value.currentWeather?.city ?? ""),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    context.select<Weathers, String>(
                        (value) => value.currentWeather?.countryName ?? ""),
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
              Builder(builder: (context) {
                String countryCode = context
                        .watch<Weathers>()
                        .currentWeather
                        ?.countryCode
                        .toUpperCase() ??
                    "UN";
                var firstChar = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
                var secondChar = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
                String flag = String.fromCharCode(firstChar) +
                    String.fromCharCode(secondChar);
                return Text(
                  flag,
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: IgnorePointer(
        ignoring: Provider.of<Weathers>(context).loading,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => context
                    .read<Weathers>()
                    .updateCurrentLocationWeather()
                    .catchError((e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                  return WeatherCode.none;
                }),
                icon: SvgPicture.asset(
                  "svgs/current-location.svg",
                  height: 48,
                  width: 48,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                ),
              ),
              //TODO: INVESTIGATE WHAT PRIMARY IS
              TextButton(
                child: Text(
                  "Weather Forecast",
                  style: kWeatherForecastTextStyle.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                onPressed: () {
                  context
                      .read<Weathers>()
                      .updateWeatherForecast()
                      .catchError((e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  });
                  Navigator.pushNamed(context, '/forecast');
                },
              ),
              IconButton(
                onPressed: () => Navigator.pushNamed(context, '/city'),
                icon: SvgPicture.asset(
                  "svgs/search-location.svg",
                  height: 48,
                  width: 48,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopMainAppBar extends StatelessWidget {
  final String title;

  const TopMainAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          Spacer(),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            ),
            onPressed: () => context
                .read<Weathers>()
                .updateCurrentLocationWeather()
                .catchError((e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                  ),
                );
              }
              return WeatherCode.none;
            }),
            icon: SvgPicture.asset(
              "svgs/current-location.svg",
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSecondaryContainer,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            ),
            onPressed: () => Navigator.pushNamed(context, '/city'),
            icon: SvgPicture.asset(
              "svgs/search-location.svg",
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherDetailCard extends StatelessWidget {
  const WeatherDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(25),
        color: Theme.of(context).colorScheme.primaryContainer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            WeatherDetailColumn(
              label: "Wind",
              iconWidget: SvgPicture.asset(
                "svgs/wind-speed.svg",
                height: 48,
                width: 48,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onPrimaryContainer,
                  BlendMode.srcIn,
                ),
              ),
              value:
                  "${context.watch<Weathers>().currentWeather?.windSpeed ?? 0.0}mph",
              textColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            WeatherDetailColumn(
              label: "Humidity",
              iconWidget: SvgPicture.asset(
                "svgs/humidity.svg",
                height: 48,
                width: 48,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onPrimaryContainer,
                  BlendMode.srcIn,
                ),
              ),
              value:
                  "${context.watch<Weathers>().currentWeather?.humidity ?? 0.0}%",
              textColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            WeatherDetailColumn(
              label: "Pressure",
              iconWidget: SvgPicture.asset(
                "svgs/pressure.svg",
                height: 48,
                width: 48,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onPrimaryContainer,
                  BlendMode.srcIn,
                ),
              ),
              value:
                  "${context.watch<Weathers>().currentWeather?.pressure ?? 0.0}hPa",
              textColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDetailColumn extends StatelessWidget {
  final String label;
  final Widget iconWidget;
  final String value;
  final Color textColor;

  const WeatherDetailColumn(
      {super.key,
      required this.label,
      required this.iconWidget,
      required this.value,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FittedBox(
          child: Text(
            label,
            style: kDetailHeaderTextStyle.copyWith(
              color: textColor,
            ),
          ),
        ),
        iconWidget,
        FittedBox(
          child: Text(
            value,
            style: kDetailValueTextStyle.copyWith(
              color: textColor,
            ),
          ),
        )
      ],
    );
  }
}
