import 'package:cuaca_klimata/services/color_scheme_notifier.dart';
import 'package:cuaca_klimata/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/landing_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Weathers>(create: (_) {
          return Weathers(null);
        }),
        ChangeNotifierProvider<ColorSchemeNotifier>(create: (_){
          return ColorSchemeNotifier(kFogCS, kFogDarkCS);
        })
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: context.watch<ColorSchemeNotifier>().colorScheme,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: context.watch<ColorSchemeNotifier>().darkColorScheme,
              useMaterial3: true,
            ),
            themeMode: ThemeMode.system,
            routes: {
              '/landing': (context) => const LandingScreen(),
              '/': (context) => const MainScreen(),
              '/city': (context) => CityScreen(),
              '/forecast': (context) => const ForecastScreen(),
            },
            initialRoute: '/landing',
          );
        }
      ),
    );
  }
}
