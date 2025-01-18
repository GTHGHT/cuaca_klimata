import 'package:cuaca_klimata/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search City"),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: ListView(
          children: [
            DropDownSettingsTile<String>(
              title: 'Weathers Service',
              settingKey: kWeatherPrefKey,
              values: <String, String>{
                "open_meteo": "Open Meteo",
                "pirate_weather": "Pirate Weather"
              },
              selected: "open_meteo",
              onChange: (value) {
                debugPrint('key-dropdown-email-view: $value');
              },
            ),
            DropDownSettingsTile<String>(
              title: 'Geocoding Service',
              settingKey: kGeocodingPrefKey,
              values: <String, String>{
                "nominatim": "Nominatim",
                "geocode": "Geocode by Map Maker"
              },
              selected: "nominatim",
              onChange: (value) {
                debugPrint('key-dropdown-email-view: $value');
              },
            ),
          ],
        ));
  }
}
