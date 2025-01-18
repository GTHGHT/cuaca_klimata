import 'package:cuaca_klimata/screens/main/forecast/forecast_bottom_sheet.dart';
import 'package:cuaca_klimata/services/data_class/weather_code.dart';
import 'package:cuaca_klimata/utilities/constants.dart';
import 'package:cuaca_klimata/utilities/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../services/notifier/color_scheme_notifier.dart';
import '../../services/notifier/weather_notifier.dart';
import '../components/loading_widget.dart';
import 'weather_detail_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    _animController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    super.initState();
    Future.microtask(() {
      var ctx = context;
      if (ctx.mounted) {
        ctx
            .read<WeatherNotifier>()
            .updateCurrentLocationWeather()
            .whenComplete(() {
          var ctxAdvanced = ctx;
          if (ctxAdvanced.mounted) {
            final weatherCode =
                ctx.read<WeatherNotifier>().currentWeather?.weatherCode;
            if (ctx.read<ColorSchemeNotifier>().colorScheme !=
                weatherCode?.colorScheme) {
              ctx.read<ColorSchemeNotifier>().colorScheme =
                  weatherCode?.colorScheme ?? kFogCS;
              ctx.read<ColorSchemeNotifier>().darkColorScheme =
                  weatherCode?.darkColorScheme ?? kFogDarkCS;
            }
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: context.watch<WeatherNotifier>().loading
          ? const LoadingWidget()
          : Stack(
              children: [
                _currentWeatherScreen(context),
                ForecastBottomSheet(),
              ],
            ),
    );
  }

  Widget _currentWeatherScreen(BuildContext context) {
    setState(() {
      _animController.forward(from: 0);
    });

    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, -0.05), end: Offset.zero)
          .animate(_animController),
      child: FadeTransition(
        opacity: _animController,
        child: _buildExpandedScreen(context),
      ),
    );
  }

  Column _buildExpandedScreen(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 16,
        ),
        _buildExpandedCountryText(),
        _buildExpandedCityText(),
        const SizedBox(
          height: 8,
        ),
        _buildExpandedWeatherIcon(),
        const SizedBox(
          height: 8,
        ),
        _buildExpandedWeatherName(context),
        _buildExpandedTempText(context),
        SizedBox(
          height: 16,
        ),
        Divider(),
        const WeatherDetailWidget(
          withCard: false,
        ),
      ],
    );
  }

  Builder _buildExpandedCountryText() => Builder(builder: (context) {
        String countryCode = context
                .watch<WeatherNotifier>()
                .currentWeather
                ?.countryCode
                .toUpperCase() ??
            "US";
        String? countryName = context.select<WeatherNotifier, String?>(
            (ws) => ws.currentWeather?.countryName);
        var firstChar = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
        var secondChar = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
        String flag =
            String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
        return Text(
          "$flag ${countryName ?? countryCode}",
          style: Theme.of(context).textTheme.bodyLarge,
        );
      });

  Text _buildExpandedCityText() => Text(
        context.select<WeatherNotifier, String>(
          (value) => value.currentWeather?.city ?? "Tidak Ditemukan",
        ),
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      );

  Builder _buildExpandedWeatherIcon() => Builder(
        builder: (context) {
          var cWeather = context.watch<WeatherNotifier>().currentWeather;
          if (cWeather != null) {
            return SvgPicture.asset(
              cWeather.weatherCode.getWeatherIcon(cWeather.isDay),
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
              height: 128,
              width: 128,
            );
          } else {
            return const SizedBox.square(dimension: 128);
          }
        },
      );

  Text _buildExpandedWeatherName(BuildContext context) => Text(
        context.select<WeatherNotifier, String>(
          (value) => value.currentWeather?.weatherName ?? "Kosong",
        ),
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      );

  Text _buildExpandedTempText(BuildContext context) => Text(
        "${context.select<WeatherNotifier, double>(
              (value) => value.currentWeather?.temp ?? 0.0,
            ).toStringFirstDecimal()}°",
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      );

  Widget _buildCompactScreen(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 8,
        ),
        _buildCompactLocation(),
        _buildCompactWeather(),
        SizedBox(
          height: 8,
        ),
        const WeatherDetailWidget(
          withCard: false,
        ),
      ],
    );
  }

  Container _buildCompactLocation() => Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_buildCompactCityAndCountry(), _buildCompactFlag()],
        ),
      );

  Column _buildCompactCityAndCountry() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.select<WeatherNotifier, String>(
                (value) => value.currentWeather?.city ?? ""),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            context.select<WeatherNotifier, String>(
                (value) => value.currentWeather?.countryName ?? ""),
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      );

  Builder _buildCompactFlag() => Builder(builder: (context) {
        String countryCode = context
                .watch<WeatherNotifier>()
                .currentWeather
                ?.countryCode
                .toUpperCase() ??
            "UN";
        var firstChar = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
        var secondChar = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
        String flag =
            String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
        return Text(
          flag,
          style: TextStyle(fontSize: 40),
        );
      });

  Container _buildCompactWeather() => Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${context.select<WeatherNotifier, double>(
                        (value) => value.currentWeather?.temp ?? 0.0,
                      ).toStringFirstDecimal()}°",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  context.select<WeatherNotifier, String>(
                    (value) => value.currentWeather?.weatherName ?? "Kosong",
                  ),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ],
            ),
            Builder(
              builder: (context) {
                var cWeather = context.watch<WeatherNotifier>().currentWeather;
                if (cWeather != null) {
                  return SvgPicture.asset(
                    cWeather.weatherCode.getWeatherIcon(cWeather.isDay),
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  );
                } else {
                  return const SizedBox.square(dimension: 128);
                }
              },
            ),
          ],
        ),
      );

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        DateFormat("d MMM y, H:mm")
            .format(context.watch<WeatherNotifier>().currentWeather?.time ??
                DateTime.now())
            .toString(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      actions: [
        _buildCurrentLocationAction(context),
        _buildSearchLocationAction(context),
        _buildSettingsAction(),
      ],
    );
  }

  Widget _buildCurrentLocationAction(BuildContext context) => IconButton(
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        onPressed: () => context
            .read<WeatherNotifier>()
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
        tooltip: "Get Current Location Weather",
      );

  Widget _buildSearchLocationAction(BuildContext context) => IconButton(
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        onPressed: () => Navigator.pushNamed(context, '/city'),
        icon: SvgPicture.asset(
          "svgs/search-location.svg",
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSecondaryContainer,
            BlendMode.srcIn,
          ),
        ),
        tooltip: "Search For Location Weather",
      );

  Widget _buildSettingsAction() => Padding(
        padding: EdgeInsets.only(right: 8),
        child: IconButton(
          onPressed: () {},
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
          icon: Icon(
            Icons.settings,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          tooltip: "Settings",
        ),
      );
}
