import 'dart:math';

import 'package:flutter/material.dart';

class HeadingArrow extends StatelessWidget {
  const HeadingArrow({
    Key? key,
    required this.heading,
  }) : super(key: key);

  final double heading;

  double _radians({required double degrees}) {
    return degrees * (pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: _radians(degrees: heading) / 2 / pi,
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
      child: SizedBox.square(
        dimension: 200,
        child: FittedBox(
            child: Icon(
          Icons.north_rounded,
          color: Colors.cyan[50],
        )),
      ),
    );
  }
}
