import 'package:cuaca_klimata/utilities/double_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utilities/constants.dart';

class DayForecastCard extends StatelessWidget {
  final String weatherIcon;
  final String weekDay;
  final double temp;
  final double feelsLike;
  final Color textColor;
  final BorderRadiusGeometry? borderRadius;

  const DayForecastCard({
    super.key,
    required this.weatherIcon,
    required this.weekDay,
    required this.temp,
    required this.feelsLike,
    this.textColor = Colors.black,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 1,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: borderRadius,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              weekDay,
              style: const TextStyle(
                fontFamily: "Noto Sans",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SvgPicture.asset(
              weatherIcon,
              width: 44,
              height: 44,
              colorFilter: ColorFilter.mode(
                textColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${temp.toStringFirstDecimal()}°",
                style: kConditionTextStyle.copyWith(
                  color: textColor,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${feelsLike.toStringFirstDecimal()}°",
                style: kConditionTextStyle.copyWith(
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
