import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late AnimationController _imageController;
  late AnimationController _textController;
  late final Animation<Offset> _textAnimation = Tween<Offset>(
    begin: const Offset(0, 0.5),
    end: Offset.zero,
  ).animate(_textController);
  late AnimationController _buttonController;
  late final Animation<Offset> _buttonAnimation = Tween<Offset>(
    begin: const Offset(0, 0.5),
    end: Offset.zero,
  ).animate(_buttonController);
  late CarouselController _carouselController;
  bool isScrolling = true;

  final _weatherIcons = [
    "svgs/day-sunny.svg",
    "svgs/night-clear.svg",
    "svgs/day-cloudy.svg",
    "svgs/night-cloudy.svg",
    "svgs/day-drizzle.svg",
    "svgs/night-drizzle.svg",
    "svgs/day-fog.svg",
    "svgs/night-fog.svg",
    "svgs/day-rain.svg",
    "svgs/night-rain.svg",
    "svgs/day-rain-freeze.svg",
    "svgs/night-rain-freeze.svg",
    "svgs/day-showers.svg",
    "svgs/night-showers.svg",
    "svgs/day-snow-showers.svg",
    "svgs/night-snow-showers.svg",
    "svgs/day-thunderstorm.svg",
    "svgs/night-thunderstorm.svg",
    "svgs/snow.svg"
  ]..shuffle();

  @override
  void initState() {
    _imageController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _buttonController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _carouselController = CarouselController(initialItem: 1);

    Timer(
      const Duration(milliseconds: 200),
      () => _imageController.forward(from: 0).then(
            (value) => _textController.forward(from: 0).then(
                  (value) => _buttonController.forward(from: 0).then(
                        (value) => _carouselController
                            .animateTo(
                              _carouselController.position.maxScrollExtent,
                              duration: Duration(seconds: 20),
                              curve: Curves.linear,
                            )
                            .whenComplete(() => isScrolling = false),
                      ),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _imageController,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 200,
                  ),
                  child: CarouselView(
                    itemExtent: MediaQuery.of(context).size.width / 1.75,
                    controller: _carouselController,
                    shrinkExtent: 8,
                    onTap: (index){
                      if(isScrolling){
                        _carouselController.jumpTo(_carouselController.offset);
                      }
                    },
                    children: List.generate(
                      _weatherIcons.length,
                      (index) => SvgPicture.asset(
                        _weatherIcons[index],
                        key: Key(_weatherIcons[index]),
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.primary,
                          BlendMode.srcIn,
                        ),
                      ),
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
                height: 50,
              ),
              FadeTransition(
                opacity: _buttonController,
                child: SlideTransition(
                  position: _buttonAnimation,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width - 64, 48),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/main');
                    },
                    child: Text(
                      "Get Started",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
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
