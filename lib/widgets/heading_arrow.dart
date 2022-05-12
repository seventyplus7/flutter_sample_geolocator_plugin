import 'dart:math';

import 'package:flutter/cupertino.dart';
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

  double _turns({required double degrees}) {
    return degrees / 360;
  }

  Widget _compass(context) {
    var font = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.cyan[50],
          fontSize: 42,
        );
    return LayoutBuilder(
      builder: (_, box) => Stack(
        children: [
          Positioned(
            top: 0,
            child: SizedBox(
                width: box.maxWidth,
                child: Text(
                  'N',
                  style: font,
                  textAlign: TextAlign.center,
                )),
          ),
          Positioned(
            right: 0,
            child: RotatedBox(
              quarterTurns: 1,
              child: SizedBox(
                width: box.maxHeight,
                child: Text('E', textAlign: TextAlign.center, style: font),
              ),
            ),
          ),
          Positioned(
            child: RotatedBox(
              quarterTurns: -1,
              child: SizedBox(
                width: box.maxHeight,
                child: Text('W', textAlign: TextAlign.center, style: font),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: RotatedBox(
              quarterTurns: 2,
              child: SizedBox(
                width: box.maxHeight,
                child: Text('S', textAlign: TextAlign.center, style: font),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedRotation(
          turns: 360 - _turns(degrees: heading),
          duration: const Duration(milliseconds: 500),
          curve: Curves.decelerate,
          child: SizedBox.square(
            dimension: 300,
            child: _compass(context),
          )),
      Positioned(
        left: 75,
        top: 75,
        child: SizedBox.square(
          dimension: 150,
          child: FittedBox(
            child: Icon(
              Icons.north_rounded,
              color: Colors.cyan[50],
            ),
          ),
        ),
      )
    ]);
  }
}
