import 'package:cuaca_klimata/screens/components/loading_widget.dart';
import 'package:cuaca_klimata/services/notifier/search_geo_notifier.dart';
import 'package:cuaca_klimata/services/notifier/weather_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilities/constants.dart';

class CityScreen extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();

  CityScreen({super.key});

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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                onSubmitted: (_) {
                  context
                      .read<SearchGeoNotifier>()
                      .searchGeo(cityController.text);
                },
                controller: cityController,
                style: kSearchCityTextStyle,
                decoration: InputDecoration(
                  hintText: "Search City",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  // fillColor: Theme.of(context).cardColor,
                  // filled: true,
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  suffix: IconButton(
                    alignment: Alignment.topRight,
                    onPressed: () async {
                      context
                          .read<SearchGeoNotifier>()
                          .searchGeo(cityController.text);
                    },
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
              if (context.watch<SearchGeoNotifier>().loading)
                LoadingWidget()
              else
                Expanded(flex: 5, child: _buildSuggestionsListView(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionsListView(BuildContext context) => ListView.builder(
        itemBuilder: (context, index) {
          var geoInfo = context.watch<SearchGeoNotifier>().suggestion?[index];
          return ListTile(
            title: Text(geoInfo?.fullName ?? ""),
            subtitle: Text(
                "${geoInfo?.latitude ?? '0.0'}, ${geoInfo?.longitude ?? '0.0'}"),
            onTap: () {
              if (geoInfo != null) {
                context.read<WeatherNotifier>().updateLocationWeather(geoInfo);
                Navigator.pop(context);
              }
            },
          );
        },
        itemCount: context.watch<SearchGeoNotifier>().suggestion?.length ?? 0,
      );
}
