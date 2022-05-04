import 'package:flutter/material.dart';

class AltitudeInfo extends StatelessWidget {
  const AltitudeInfo({Key? key, required this.altitude}) : super(key: key);

  final double altitude;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: 64,
          child: FittedBox(
            child: Icon(
              Icons.show_chart_rounded,
              color: Colors.cyan[50],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$altitude m',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.cyan[50], fontSize: 64),
        ),
      ],
    );
  }
}
