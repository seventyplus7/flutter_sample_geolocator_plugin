import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoProvider with ChangeNotifier {
  Position? _position;

  Position? get position {
    return _position;
  }

  GeoProvider() {
    Geolocator.checkPermission().then((permission) {
      if (permission == LocationPermission.denied) {
        Geolocator.requestPermission().then((requestPermission) {
          if (requestPermission == LocationPermission.denied ||
              requestPermission == LocationPermission.deniedForever) {
            debugPrint('Denied of required permissions');
          }
        });
      }
    });

    LocationSettings locationSettings = const LocationSettings(accuracy: LocationAccuracy.high);

    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (position) {
        _position = position;
        notifyListeners();
      },
      onError: (_) {
        _position = null;
        notifyListeners();
      },
    );
  }
}
