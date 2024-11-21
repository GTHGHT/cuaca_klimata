import 'package:cuaca_klimata/services/data_class/weather_code.dart';
import 'package:cuaca_klimata/utilities/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      bottomNavigationBar: const MainAppBar(),
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
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  DateFormat("d MMM y").format(DateTime.now()).toString(),
                  style: kDateTextStyle.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  context.select<Weathers, String>(
                    (value) => value.currentWeather?.city ?? "Tidak Ditemukan",
                  ),
                  style: kCityTextStyle.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Flexible(
                child: Image.asset(
                  context
                          .watch<Weathers>()
                          .currentWeather
                          ?.weatherCode
                          .weatherIconLocation ??
                      "images/broken_white.png",
                  fit: BoxFit.fitHeight,
                  color: Theme.of(context).colorScheme.primary,
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Flexible(
                child: Text(
                  context.select<Weathers, String>(
                    (value) => value.currentWeather?.weatherName ?? "Kosong",
                  ),
                  style: kConditionTextStyle.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Text(
                "${context.select<Weathers, double>(
                      (value) => value.currentWeather?.temp ?? 0.0,
                    ).toStringFirstDecimal()}°",
                style: kTempTextStyle.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const WeatherDetailCard(),
            ],
          ),
        ),
      ),
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
                icon: const FaIcon(
                  FontAwesomeIcons.locationCrosshairs,
                  size: 32,
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
                icon: const FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
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
              icon: const AssetImage("images/wind_white.png"),
              value:
                  "${context.watch<Weathers>().currentWeather?.windSpeed ?? 0.0}mph",
              textColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            WeatherDetailColumn(
              label: "Humidity",
              icon: const AssetImage("images/humidity_white.png"),
              value:
                  "${context.watch<Weathers>().currentWeather?.humidity ?? 0.0}%",
              textColor: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            WeatherDetailColumn(
              label: "Pressure",
              icon: const AssetImage("images/pressure_white.png"),
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
  final ImageProvider icon;
  final String value;
  final Color textColor;

  const WeatherDetailColumn(
      {super.key,
      required this.label,
      required this.icon,
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
        Image(
          image: icon,
          width: 50,
          height: 50,
          color: textColor,
        ),
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
