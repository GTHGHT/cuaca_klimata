
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HourForecastGrid extends StatelessWidget {
  final String weatherIcon;
  final String hour;
  final double temp;
  final Color contentsColor;
  final Color containerColor;

  const HourForecastGrid(
      {super.key,
        required this.weatherIcon,
        required this.hour,
        required this.temp,
        this.contentsColor = Colors.black,
        this.containerColor = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: containerColor,
      ),
      height: 100,
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            hour,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: contentsColor),
          ),
          SvgPicture.asset(
            weatherIcon,
            height: 40,
            width: 40,
            colorFilter: ColorFilter.mode(contentsColor, BlendMode.srcIn),
          ),
          Text(
            "$temp°",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: contentsColor),
          )
        ],
      ),
    );
  }
}
