import 'package:cuaca_klimata/services/data_class/weather_code.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/color_scheme_notifier.dart';
import '../../services/weather_service.dart';
import '../../utilities/constants.dart';

class CityScreen extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();

  CityScreen({super.key});

  Future<void> updateWeather(BuildContext context) async {
    WeatherCode result = await Provider.of<WeatherService>(context, listen: false)
        .updateCityWeather(cityController.text)
        .catchError((e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
      return WeatherCode.none;
    });
    if (context.mounted) {
      context.read<ColorSchemeNotifier>().colorScheme = result.colorScheme;
      context.read<ColorSchemeNotifier>().darkColorScheme =
          result.darkColorScheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search City"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.all(20),
          child: TextField(
            onSubmitted: (_) async {
              await updateWeather(context);
              if (context.mounted) {
                Navigator.popUntil(context, ModalRoute.withName("/"));
              }
            },
            controller: cityController,
            style: kSearchCityTextStyle,
            decoration: InputDecoration(
              labelText: "Search City",
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.all(5).copyWith(left: 15),
              fillColor: Theme.of(context).cardColor,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              suffix: IconButton(
                alignment: Alignment.topRight,
                onPressed: () async {
                  await updateWeather(context);
                  if (context.mounted) {
                    Navigator.popUntil(context, ModalRoute.withName("/"));
                  }
                },
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
