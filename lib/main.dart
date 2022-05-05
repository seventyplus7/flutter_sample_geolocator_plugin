import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'geo/geo.dart';
import 'widgets/altitude_info.dart';
import 'widgets/heading_arrow.dart';
import 'widgets/speed_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Geolocator Plugin Sample',
      theme: ThemeData(primarySwatch: Colors.red, scaffoldBackgroundColor: Colors.redAccent),
      home: ChangeNotifierProvider(
        create: (_) => GeoProvider(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  Widget _currentPositionInfo(Position? position) {
    return position != null
        ? SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HeadingArrow(heading: position.heading),
                SpeedInfo(speed: position.speed),
                AltitudeInfo(altitude: position.altitude)
              ],
            ),
          )
        : Center(
            child: SizedBox.square(
              dimension: 200,
              child: FittedBox(
                child: Icon(
                  Icons.error,
                  color: Colors.cyan[50],
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 8.0,
              right: 8.0,
              child: SizedBox.square(
                dimension: 64,
                child: FittedBox(
                  child: IconButton(
                    splashRadius: 24,
                    onPressed: () {},
                    icon: Icon(
                      Icons.history,
                      color: Colors.cyan[50],
                    ),
                  ),
                ),
              ),
            ),
            _currentPositionInfo(
              context.select<GeoProvider?, Position?>((geo) => geo?.position),
            ),
          ],
        ),
      ),
    );
  }
}
