import 'package:flutter/foundation.dart';
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

    late LocationSettings locationSettings;
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
                "Example app will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          ));
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 100,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }

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
