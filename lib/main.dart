import 'package:provider/provider.dart';

import '../screens/landing_screen.dart';
import 'package:flutter/material.dart';

import 'screens/city_screen.dart';
import 'screens/forecast_screen.dart';
import 'screens/main_screen.dart';
import 'services/weathers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Weathers>(
      create: (_) {
        final weathers = Weathers(null);
        return weathers;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        routes: {
          '/landing': (context) => const LandingScreen(),
          '/': (context) => const MainScreen(),
          '/city': (context) => CityScreen(),
          '/forecast': (context) => const ForecastScreen(),
        },
        initialRoute: '/landing',
      ),
    );
  }
}