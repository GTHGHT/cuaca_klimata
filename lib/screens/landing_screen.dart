import 'dart:async';

import 'package:cuaca_klimata/services/color_scheme_notifier.dart';
import 'package:cuaca_klimata/services/data_class/weather_code.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/weathers.dart';
import '../utilities/constants.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late Animation<Offset> _imageAnimation;
  late AnimationController _textController;
  late Animation<Offset> _textAnimation;
  late AnimationController _buttonController;
  late Animation<Offset> _buttonAnimation;

  @override
  void initState() {
    _imageController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _imageAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(_imageController);
    _textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _textAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(_textController);
    _buttonController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _buttonAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(_buttonController);
    Timer(
      const Duration(milliseconds: 200),
      () => _imageController.forward(from: 0).then(
            (value) => _textController.forward(from: 0).then(
                  (value) => _buttonController.forward(from: 0),
                ),
          ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FadeTransition(
                opacity: _imageController,
                child: SlideTransition(
                  position: _imageAnimation,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            kWeatherImageList[index % kWeatherImageList.length],
                            fit: BoxFit.fitHeight,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              FadeTransition(
                opacity: _textController,
                child: SlideTransition(
                  position: _textAnimation,
                  child: const Column(
                    children: [
                      Text(
                        "Discover the Weather\n"
                        "In Your City",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Find out what can be waiting for you\n"
                        "on the street with a few taps",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Quicksand",
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
              ),
              FadeTransition(
                opacity: _buttonController,
                child: SlideTransition(
                  position: _buttonAnimation,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                      vertical: 25,
                      horizontal: 10,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6CC1F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        context
                            .read<Weathers>()
                            .updateCurrentLocationWeather()
                            .then((value) {
                              if(context.mounted){
                                context.read<ColorSchemeNotifier>().colorScheme = value.colorScheme;
                                context.read<ColorSchemeNotifier>().darkColorScheme = value.darkColorScheme;
                              }
                        });
                        //     .catchError((e) {
                        //       if(context.mounted){
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //           SnackBar(
                        //             content: Text(e.toString()),
                        //           ),
                        //         );
                        //       }
                        // });
                        Navigator.pushNamed(context, '/');
                      },
                      child: const Text(
                        "Get Started",
                        style: kLandingButtonTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
