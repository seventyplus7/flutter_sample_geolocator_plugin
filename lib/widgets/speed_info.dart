import 'package:flutter/material.dart';

class SpeedInfo extends StatelessWidget {
  const SpeedInfo({Key? key, required this.speed}) : super(key: key);

  final double speed;

  double _speedToKpH({required double speed}) {
    return speed * 3.6;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: 64,
          child: FittedBox(
            child: Icon(
              Icons.speed_rounded,
              color: Colors.cyan[50],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${_speedToKpH(speed: speed).round()} kph',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Colors.cyan[50], fontSize: 64),
        ),
      ],
    );
  }
}
