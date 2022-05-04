import 'package:flutter/material.dart';
import 'package:flutter_sample_geolocator_plugin/geo/geo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    var position = context.select<GeoProvider?, Position?>((geo) => geo?.position);
    return Scaffold(
      body: position != null
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
            ),
    );
  }
}
