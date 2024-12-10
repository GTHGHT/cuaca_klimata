import 'package:cuaca_klimata/services/color_scheme_notifier.dart';
import 'package:cuaca_klimata/services/weather_forecast_service.dart';
import 'package:cuaca_klimata/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/city/city_screen.dart';
import 'screens/forecast/forecast_screen.dart';
import 'screens/landing/landing_screen.dart';
import 'screens/main/main_screen.dart';
import 'services/interface/geocoding_integration.dart';
import 'services/interface/weather_integration.dart';
import 'services/nominatim_geocoding.dart';
import 'services/open_meteo_weather.dart';
import 'services/weather_service.dart';

void main() async {
  runApp(const MyApp());
}

Future<WeatherIntegration> loadWeatherIntegration() async {
  SharedPreferencesAsync spAsync = SharedPreferencesAsync();
  String? geoServicePref = await spAsync.getString('geocoding_integration');
  GeocodingIntegration geoWeatherService = switch (geoServicePref) {
    'nominatim' => NominatimGeocoding(),
    _ => NominatimGeocoding()
  };

  String? wServicePref = await spAsync.getString('weather_integration');
  WeatherIntegration currentWeatherService = switch (wServicePref) {
    "open_meteo" => OpenMeteoWeather(geoWeatherService),
    _ => OpenMeteoWeather(geoWeatherService),
  };
  return currentWeatherService;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WeatherIntegration? weatherIntegration;

  @override
  void initState() {
    loadWeatherIntegration().then((value) => weatherIntegration = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WeatherService>(create: (_) {
          return WeatherService(weatherIntegration);
        }),
        ChangeNotifierProvider<WeatherForecastService>(create: (_) {
          return WeatherForecastService(weatherIntegration);
        }),
        ChangeNotifierProvider<ColorSchemeNotifier>(create: (_) {
          return ColorSchemeNotifier(kCloudyCS, kCloudyDarkCS);
        })
      ],
      child: Builder(builder: (context) {
        var whiteTypo = Typography().white;
        var blackTypo = Typography().black;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: context.watch<ColorSchemeNotifier>().colorScheme,
            useMaterial3: true,
            fontFamily: 'Noto Sans',
            textTheme: blackTypo.copyWith(
              displayLarge: blackTypo.displayLarge?.copyWith(
                fontFamily: 'Quicksand',
              ),
              displayMedium: blackTypo.displayMedium?.copyWith(
                fontFamily: 'Quicksand',
              ),
              displaySmall: blackTypo.displaySmall?.copyWith(
                fontFamily: 'Quicksand',
              ),
              headlineLarge: blackTypo.headlineLarge?.copyWith(
                fontFamily: 'Quicksand',
              ),
              headlineMedium: blackTypo.headlineMedium?.copyWith(
                fontFamily: 'Quicksand',
              ),
              headlineSmall: blackTypo.headlineSmall?.copyWith(
                fontFamily: 'Quicksand',
              ),
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: context.watch<ColorSchemeNotifier>().darkColorScheme,
            useMaterial3: true,
            fontFamily: 'Noto Sans',
            textTheme: whiteTypo.copyWith(
              displayLarge: whiteTypo.displayLarge?.copyWith(
                fontFamily: 'Quicksand',
              ),
              displayMedium: blackTypo.displayMedium?.copyWith(
                fontFamily: 'Quicksand',
              ),
              displaySmall: blackTypo.displaySmall?.copyWith(
                fontFamily: 'Quicksand',
              ),
              headlineLarge: blackTypo.headlineLarge?.copyWith(
                fontFamily: 'Quicksand',
              ),
              headlineMedium: blackTypo.headlineMedium?.copyWith(
                fontFamily: 'Quicksand',
              ),
              headlineSmall: blackTypo.headlineSmall?.copyWith(
                fontFamily: 'Quicksand',
              ),
            ),
          ),
          themeMode: ThemeMode.system,
          routes: {
            '/landing': (context) => const LandingScreen(),
            '/main': (context) => const MainScreen(),
            '/city': (context) => CityScreen(),
            // '/forecast': (context) => const ForecastScreen(),
          },
          initialRoute: '/landing',
        );
      }),
    );
  }
}
