
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WeatherInfoItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final String value;
  final Color? circleColor;
  final Color? iconColor;

  const WeatherInfoItem(
      {super.key,
        required this.iconPath,
        required this.label,
        required this.value,
        this.circleColor,
        this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
            circleColor ?? Theme.of(context).colorScheme.secondaryContainer,
            child: SvgPicture.asset(
              iconPath,
              height: 48,
              width: 48,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                iconColor ?? Theme.of(context).colorScheme.onSecondaryContainer,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(
            width: 4,
            height: 48,
            // child: VerticalDivider(
            //   thickness: 2,
            // ),
          ),
          SizedBox(
            width: 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(200)
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ],
      ),
    );
  }
}