import '../services/weathers.dart';
import '../utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CityScreen extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();

  CityScreen({super.key});

  void updateWeather(BuildContext context) async {
    await Provider.of<Weathers>(context, listen: false)
        .updateCityWeather(cityController.text)
        .catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search City"),
        centerTitle: true,
        backgroundColor: kScaffoldBGColor,
      ),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          padding: const EdgeInsets.all(20),
          child: TextField(
            onSubmitted: (_) => updateWeather(context),
            controller: cityController,
            style: kSearchCityTextStyle,
            decoration: InputDecoration(
              labelText: "Search City",
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: const EdgeInsets.all(5).copyWith(left: 15),
              fillColor: kForecastTileColor,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              suffix: IconButton(
                alignment: Alignment.topRight,
                onPressed: () => updateWeather(context),
                icon: const FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: kTextFieldCursorColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}