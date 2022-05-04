import 'package:flutter/material.dart';
import 'package:flutter_sample_geolocator_plugin/widgets/altitude_info.dart';
import 'package:flutter_sample_geolocator_plugin/widgets/speed_info.dart';
import 'package:geolocator/geolocator.dart';

import 'widgets/heading_arrow.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Geolocator.checkPermission().then((permission) {
      if (permission == LocationPermission.denied) {
        Geolocator.requestPermission().then((requestPermission) {
          if (requestPermission == LocationPermission.denied ||
              requestPermission == LocationPermission.deniedForever) {
            var errorSnackBar = const SnackBar(content: Text('Denied of required permissions'));
            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
          }
        });
      }
    });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    return Scaffold(
      body: StreamBuilder(
        stream: Geolocator.getPositionStream(locationSettings: locationSettings),
        builder: (ctx, AsyncSnapshot<Position> snapshot) {
          if (snapshot.hasData) {
            var position = snapshot.data;
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeadingArrow(heading: position?.heading ?? 0.0),
                  SpeedInfo(speed: position?.speed ?? 0.0),
                  AltitudeInfo(altitude: position?.altitude ?? 0.0)
                ],
              ),
            );
          }
          return Center(
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
        },
      ),
    );
  }
}
